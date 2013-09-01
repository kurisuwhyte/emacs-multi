Multi
=====

[![Build Status](https://secure.travis-ci.org/kurisuwhyte/emacs-multi.png)](http://travis-ci.org/kurisuwhyte/emacs-multi)
[![stable](http://hughsk.github.io/stability-badges/dist/stable.svg)](http://github.com/hughsk/stability-badges)

Clojure-style multi-methods for Emacs Lisp.

A multi-method is the combination of a dispatch function, and one or
more methods. When a multi-method is applied, the dispatching function
is first applied to the given arguments, and its return value is used to
select the correct method branch to apply. A default method branch may
be defined, which will be applied if none of the branches match.

> **Note:** Multi requires lexical binding, thus it's only compatible
> with Emacs 24+


## Example

```elisp
(require 'multi)

(defmulti area (x &rest _) x)

(defmethod area 'rect (_ w h)
  (* w h))

(defmethod area 'circle (_ r)
  (* float-pi (* r r)))

(defmethod-fallback area (&rest _) 'oops)

(area 'rect 4 13) ;; => 52
(area 'circle 12) ;; => 452.3893421169302
(area 'sphere 12) ;; => 'oops
```


## Installation

You can grab it from [marmalade](http://marmalade-repo.org/):

    M-x package-install multi

Alternatively you can just dump `multi.el` somewhere in your load path.


### Using in a package

Add `(multi "1.0.1")` to your package requires. E.g.:

    ;; Package-Requires: ((multi "1.0.1"))


## Tests

Run `./run-tests.sh`.


## Documentation

This package provides a form of polymorphism by way of predicate
dispatching. Methods consist of a dispatch function, and a series of
branches. The dispatch function is applied to the arguments, and the
result value is checked against the expectations of each branch to
define which one to invoke.

A default branch may be defined for a multi-method, and will be invoked
if none of the defined cases match the result of applying the dispatch
function. Branches may be defined or removed at any point in time, but
it's an error to define a branch that has the same expectations of an
existing one.


### `defmulti (name arguments . body)`

```hs
macro defmulti :: (Id, [Id], ...Form) → Unit
```

Defines a new multi-method with the given name, and using the specified
dispatch rules. A generic function is defined in the global table with
the given name.


### `defmethod (name premise arguments . body)`

```hs
macro defmethod :: (Id, a, [Id], ...Form) → Unit
```

Defines a new branch for the multi-method with the given name. The
branch is applied whenever the multi-method dispatching function returns
a value that matches the `premise`.

It's an error to provide a `promise` that's already being used for some
other branch in the same multi-method.


### `defmethod-fallback (name arguments . body)`

```hs
macro defmethod-fallback :: (Id, [Id], ...Form) → Unit
```

Replaces the default branch for the multi-method. The default branch is
applied when none of the branches specified for a multi-method matches
the dispatch value.

The default behaviour is to throw an exception.


### `multi-remove-method (name premise)`

```hs
fun multi-remove-method :: (Id, a) → Unit
```

Removes the branch that matches the given `premise` from the
multi-method.


### `multi-remove-method-fallback (name)`

```hs
fun multi-remove-method-fallback :: Id → Unit
```

Removes the fallback method associated with a multi-method.


## Support

Just open an issue if you're facing a particular problem. Bonus points
if you attach a pull-request ;)

Feel free to ping me on [Twitter](http://twitter.com/kurisuwhyte) or
`#emacs` on Freenode IRC(I'm `kurisumasu`) for anything else.


## Licence

MIT





