# assignments
ASSIGNMENT ?= ""
IGNOREDIRS := "^(\.git|bin|docs|exercises)$$"
ASSIGNMENTS = $(shell find ./exercises -maxdepth 1 -mindepth 1 -type d | awk -F/ '{print $$NF}' | sort | grep -Ev $(IGNOREDIRS))

# output directories
TMPDIR ?= "/tmp"
OUTDIR := $(shell mktemp -d "$(TMPDIR)/$(ASSIGNMENT).XXXXXXXXXX")

# language specific config (tweakable per language)
FILEEXT := "f90"
TESTEXT := "fun"
EXAMPLE := "example.$(FILEEXT)"
TESTNAME := $(shell echo $(ASSIGNMENT) | sed -e "s/-/_/g")
TSTFILE := "$(TESTNAME).$(TESTEXT)"

# compiler flags
export FSFLAG := "-I"
export FC := "gfortran"
export CXX := "g++"
export CC := "gcc"

default:
	gem install funit

help: ## Prints this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install-test: ## install test dependency: funit
	@gem install funit

test-assignment: ## run single test using ASSIGNMENTS: test-assignment ASSIGNMENT=wordy
	@echo "running tests for: $(ASSIGNMENT)"
	@cat ./exercises/$(ASSIGNMENT)/$(TSTFILE) | sed 's/Xtest/test/' > $(OUTDIR)/$(TSTFILE)
	@cp ./exercises/$(ASSIGNMENT)/$(EXAMPLE) $(OUTDIR)/$(TESTNAME).$(FILEEXT)
	@cd $(OUTDIR) && funit

test: ## run all tests
	@for assignment in $(ASSIGNMENTS); do ASSIGNMENT=$$assignment $(MAKE) -s test-assignment || exit 1; done

