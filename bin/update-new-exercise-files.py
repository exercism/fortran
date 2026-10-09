#!/usr/bin/env python3

"""Create starter files for a new practice exercise.

Writes a stub solution (<exercise>.f90), a stub example (.meta/example.f90)
and a starter test template (.meta/template.j2). Existing files are left
untouched. The exercise directory and its .meta/config.json must already
exist (run `bin/configlet sync` first).

After editing the template, generate the test file with `bin/generate_tests`.
See docs/MAINTAINERS.md for the full workflow.

Example:

$ python3 bin/update-new-exercise-files.py -e exercises/practice/bob
$ bin/generate_tests bob
"""

import argparse
import json
import os
import pathlib
import textwrap


class Exercise:
    """Exercise holds exercise data."""

    def __init__(self, exercise_path):
        exercise_path = pathlib.Path(exercise_path)
        if not exercise_path.exists():
            raise ValueError(f"{exercise_path} does not exist")
        if not exercise_path.is_dir():
            raise ValueError(f"{exercise_path} is not a directory")

        slug = exercise_path.name
        self.config = json.loads((exercise_path / ".meta" / "config.json").read_text())

        self.slug = slug
        self.name = slug.replace("-", "_")
        self.path = exercise_path

    def config_file(self, filetype):
        if len(self.config["files"][filetype]) != 1:
            raise ValueError(f"Expected exactly one {filetype} file; got {self.config["files"][filetype]!r}")
        return self.path / self.config["files"][filetype][0]

    def write_file(self, filepath, content):
        if filepath.exists():
            print(f"{filepath} already exists; will not replace.")
        else:
            filepath.write_text(content.strip() + "\n")
            print(f"Wrote to {filepath}")

    def write_stub_file(self, content):
        self.write_file(self.config_file("solution"), content)

    def write_example_file(self, content):
        self.write_file(self.config_file("example"), content)

    def write_test_template(self, content):
        filepath = self.path / ".meta/template.j2"
        self.write_file(filepath, content)


def stub_implementation(exercise_name: str) -> str:
    return textwrap.dedent(f"""\
        module {exercise_name}
          implicit none
        contains

          logical function dummy()
            dummy=.true.
          end function

        end module
    """)


def template_stub() -> str:
    return textwrap.dedent("""\
        {{ header }}

        program {{ name }}_test_main
          use TesterMain
          use {{ name }}

          implicit none
        {% for case in cases %}
          ! Test {{ loop.index }}: {{ case["description"] }}
        {%- if not case["expect_error"] %}
          call assert_equal({{ case["expected"] }}, {{ case["property"] }}({{ case["input"]["..."] }}), "{{ case["description"] }}")
        {%- else %}
          call assert_equal(-1, {{ case["property"] }}({{ case["input"]["number"] }}), "{{ case["description"] }}")
        {%- endif %}
        {% endfor %}
          call test_report()

        end program
    """)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create exercise")
    parser.add_argument("-e", "--exercise_path", required=True, help="The path of the exercise")

    args = parser.parse_args()
    exercise = Exercise(args.exercise_path)

    exercise.write_stub_file(stub_implementation(exercise.name))
    exercise.write_example_file(stub_implementation(exercise.name))
    exercise.write_test_template(template_stub())

    print(f"Use './bin/generate_tests {exercise.slug}' to generate the test file from the Jinja template ({exercise.path / ".meta/template.j2"}).")
