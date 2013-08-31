EMACS = $(shell which emacs)

test:
	$(EMACS) --version
	$(EMACS) -batch -l ert -l multi.el -l tests/multi.el \
		 -f ert-run-tests-batch-and-exit


.PHONY: test
