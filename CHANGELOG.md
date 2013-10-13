## From 2.0.0 to 2.0.1

### Minor additions

 - Makes support for *docstrings* in `defmulti` more explicit for Emacs'
   internal help commands.
   
 - Updates documentation to reflect such changes.


## From 1.0.1 to 2.0.0

### Breaking changes

 -  Renames `defmethod` & `defmethod-fallback` to avoid collisions with the
    `eieio` package included with Emacs. [See the issue for discussion][4]

### Minor additions

 -  Instrument `defmulti` for debugging with Edebug;
 
 -  Supports docstrings for `defmulti` forms;
 
 -  Fontifies `defmulti`, `defmulti-method` and `defmethod-fallback` forms;
    
[4]: https://github.com/kurisuwhyte/emacs-multi/issues/4


## From 1.0.0 to 1.0.1

 -  [Fix problem with methods being garbage collected][2]
 
 [2]: https://github.com/kurisuwhyte/emacs-multi/issues/2
