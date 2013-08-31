#!/bin/bash
if [[ -z "$EMACS" ]]; then
    EMACS="emacs"
fi

echo `$EMACS --version`
$EMACS -batch -l ert -l multi.el -l tests/multi.el \
       -f ert-run-tests-batch-and-exit
