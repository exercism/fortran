#!/usr/bin/env python3

"""Test generator v1."""

import argparse
import datetime
import json
import os
import pathlib
import re
import shlex
import subprocess
import sys
import textwrap
import tomllib

import jinja2


def problem_spec_dir() -> pathlib.Path:
    """Detect and return the problem specs."""
    cache_dir = os.getenv("XDG_CACHE_HOME") or pathlib.Path.home() / ".cache"
    specs = pathlib.Path(cache_dir) / "exercism/configlet/problem-specifications"
    if specs.exists():
        return specs
    cur = pathlib.Path(os.getcwd())
    for i in cur.parents:
        if i.name == "problem-specifications":
            return i
    raise LookupError("Could not find problem specs")


def flatten_cases(cases: list[dict]) -> list[tuple[list[str], dict]]:
    """Recursive flatten test cases, returning individual cases with parent descriptions."""
    for case_or_group in cases:
        if "cases" in case_or_group:
            for groups, child_case in flatten_cases(case_or_group["cases"]):
                yield ([case_or_group["description"]] + groups, child_case)
        else:
            yield ([], case_or_group)


def get_cases(specs: pathlib.Path, exercise: pathlib.Path) -> list[dict]:
    """Return flattened, filtered cases with additional metadata attached."""
    canonical_path = specs / "exercises" / exercise.name / "canonical-data.json"
    with open(canonical_path, "r", encoding="utf-8") as f:
        canonical = json.load(f)
    with open(exercise / ".meta" / "tests.toml", "rb") as f:
        tests = tomllib.load(f)

    reimplemented = {
        test["reimplements"]
        for test in tests.values()
        if test.get("include", True) and "reimplements" in test
    }
    cases = []
    for groups, case in flatten_cases(canonical["cases"]):
        # Filter out test cases with include=false or not listed.
        if case["uuid"] not in tests or case["uuid"] in reimplemented:
            continue
        if not tests[case["uuid"]].get("include", True):
            continue
        # Add metadata.
        case["descriptions"] = groups + [case["description"]]
        case["expect_error"] = isinstance(case["expected"], dict) and "error" in case["expected"]
        if case["expect_error"]:
            case["expect_error_msg"] = case["expected"]["error"]
        cases.append(case)
    return cases


def filter_tojson(data, separators=(',', ':'), indent=None) -> str:
    """Filter `tojson` that JSON encodes a string with flexible settings."""
    return json.dumps(data, separators=separators, indent=indent)


def filter_escape_whitespace_and_quote(data: str) -> str:
    """Escape whitespace using CARRIAGE_RETURN, TAB and NEWLINE, then quote."""
    data = f'"{data}"'
    for char, replacement in [("\n", "NEWLINE"), ("\t", "TAB"), ("\r", "CARRIAGE_RETURN")]:
        data = data.replace(char, f'" // {replacement} // "')
    while '// "" //' in data:
        data = data.replace('// "" //', "//")
    return data


def fortran_literal(x) -> str:
    """Format a Python scalar as a Fortran literal."""
    if isinstance(x, bool):
        return ".true." if x else ".false."
    if isinstance(x, str):
        return '"' + x.replace('"', '""') + '"'
    return str(x)


def filter_fortran_matrix(
    data: list[list] | list[str], type_spec: str | None = None, indent: int = 6, max_width: int = 80
) -> str:
    """Convert row-major nested lists to a Fortran column-major `reshape` expression.

    Each row may be a list of scalars or a string (one element per character).
    `type_spec` (e.g. "integer" or "character(len=1)") is emitted as an array
    constructor type spec; it is required when `data` has no elements.
    Expressions longer than `max_width` are split with `&` continuations, one
    matrix row per line, each indented by `indent` spaces, to stay within
    Fortran's 132-character line limit.
    """
    rows = len(data)
    cols = len(data[0]) if rows else 0
    row_strs = [", ".join(fortran_literal(x) for x in row) for row in data if len(row)]
    if not row_strs and not type_spec:
        raise ValueError("fortran_matrix needs a type_spec for an empty matrix")
    prefix = f"{type_spec} :: " if type_spec else ""
    suffix = f"], [{rows}, {cols}], order=[2, 1])"

    single = f"reshape([{prefix}{', '.join(row_strs)}".rstrip() + suffix
    if len(single) <= max_width:
        return single
    sep = ", &\n" + " " * indent
    return f"reshape([{prefix}&\n" + " " * indent + sep.join(row_strs) + suffix


def jinja_env(exercise: pathlib.Path) -> jinja2.Environment:
    """Return a configured Jinja env with filters added."""
    env = jinja2.Environment(loader=jinja2.FileSystemLoader(exercise / ".meta"))
    # Shell quoting
    env.filters["quote"] = shlex.quote
    # JSON formatting, default to compact form (`jq -c`).
    env.filters["tojson"] = filter_tojson
    # String escaping, ANSI-C style.
    env.filters["repr"] = repr
    env.filters["camel_to_snake"] = lambda x: re.sub(r"([a-z])([A-Z])", (lambda m: f"{m.group(1)}_{m.group(2).lower()}"), x)
    env.filters["format_list"] = lambda x: shlex.quote(
        "[" + ",".join(f'"{i}"' if isinstance(i, str) else str(i) for i in x) + "]"
    )
    # Replace whitespace with chars and concatenation.
    env.filters["escape_quote_whitespace"] = filter_escape_whitespace_and_quote
    # Row-major nested lists to Fortran matrix.
    env.filters["fortran_matrix"] = filter_fortran_matrix

    return env


def bool_to_str(obj):
    """Recursively convert boolean values to strings in collections."""
    if isinstance(obj, dict):
        return {key: bool_to_str(val) for key, val in obj.items()}
    if isinstance(obj, list):
        return [bool_to_str(val) for val in obj]
    if obj is True:
        return ".true."
    if obj is False:
        return ".false."
    return obj


def generate(specs: pathlib.Path, exercise: pathlib.Path) -> None:
    """Generate and write test file for a given spec and exercise."""
    cases = get_cases(specs, exercise)
    for case in cases:
        case["expected"] = bool_to_str(case["expected"])

    timestamp = datetime.datetime.now(tz=datetime.UTC).replace(microsecond=0).isoformat()
    header = f"""! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/{exercise.name}/canonical-data.json
! File last updated on {timestamp}"""
    data = {
        "cases": cases,
        "header": header,
        "solution": json.loads((exercise / ".meta/config.json").read_text())["files"]["solution"][0],
        "name": exercise.name.replace("-", "_"),
    }

    # Render the template.
    try:
        template = jinja_env(exercise).get_template("template.j2")
        out = template.render(data)
    except jinja2.exceptions.TemplateAssertionError as e:
        e.add_note(f"Error rendering template for {exercise.name}")
        raise

    # Check for changes or the lack thereof.
    test_file = exercise / json.loads((exercise / ".meta/config.json").read_text())["files"]["test"][0]
    if test_file.exists():
        old_content = [i for i in test_file.read_text().strip().splitlines() if "last updated on" not in i]
        new_content = [i for i in out.splitlines() if "last updated on" not in i]
        if old_content == new_content:
            return

    # Write the test file.
    test_file.write_text(out + "\n")


def argparser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--no-pull",
        action="store_false",
        dest="pull",
        help="Do not run `git pull` on the problem specs repo",
    )
    parser.add_argument(
        "exercises",
        nargs="*",
        help="exercises to generate tests; if none supplied, generate all"
    )
    return parser


def main():
    """Main entrypoint."""
    specs = problem_spec_dir()
    args = argparser().parse_args()
    if args.pull:
        subprocess.check_call(["git", "pull"], cwd=specs)
    exercises = args.exercises
    # Generate all exercises with templates if none are specified as args.
    if not exercises:
        exercises = [
            i.parent.parent
            for i in pathlib.Path("exercises/practice").glob("*/.meta/template.j2")
        ]
    else:
        # Turn strings to paths and make them relative to the practice exercises.
        out = []
        practice = pathlib.Path("exercises/practice")
        for exercise in exercises:
            path = pathlib.Path(exercise)
            if not path.is_relative_to(practice):
                path = practice / path
            out.append(path)
        exercises = out

    for exercise in exercises:
        exercise_path = pathlib.Path(exercise)
        if not exercise_path.exists():
            raise ValueError(f"Exercise {exercise_path} does not exist")
        generate(specs, exercise_path)


if __name__ == "__main__":
    main()
