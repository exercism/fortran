# make        build and run the tests
# make clean  remove build output

# Don't let make's built-in rules treat .mod files as Modula-2 source.
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin FC),default)
FC = gfortran
endif
FFLAGS ?= -g -std=f2008 -W -Wall -Wextra -pedantic -fbacktrace

TEST := $(basename $(wildcard *_test.f90))
SOLUTION := $(TEST:_test=)

.PHONY: test clean

test: run_tests
	@./run_tests

run_tests: TesterMain.o $(SOLUTION).o $(TEST).o
	$(FC) $(FFLAGS) $^ -o $@

$(TEST).o: $(SOLUTION).o TesterMain.o

%.o: %.f90
	$(FC) $(FFLAGS) -c $< -o $@

clean:
	rm -f *.o *.mod run_tests
