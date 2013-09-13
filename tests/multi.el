(require 'ert)
(require 'multi)

(defun reset-state ()
  (remhash 'multi/-test multi/-method-branches)
  (remhash 'multi/-test multi/-method-fallbacks)
  (fmakunbound 'multi/-test))

(ert-deftest multi/defmulti-should-create-a-new-multi-method ()
  (defmulti multi/-test (a) a)
  (unwind-protect
      (should (fboundp 'multi/-test))
    (reset-state)))

(ert-deftest multi/defmulti-should-use-function-for-dispatching ()
  (defmulti multi/-test (a) 1)
  (unwind-protect
      (progn
  (defmulti-method multi/-test 1 (a) a)
  (should (= 2 (multi/-test 2))))
    (reset-state)))

(ert-deftest multi/defmulti-should-use-structural-equality ()
  (defmulti multi/-test (&rest _) '(multi method))
  (unwind-protect
      (progn
  (defmulti-method multi/-test '(multi method) (a) a)
  (should (= 2 (multi/-test 2))))
    (reset-state)))

(ert-deftest multi/defmulti-should-use-fallback-if-no-branches-match ()
  (defmulti multi/-test (a &rest _) a)
  (unwind-protect
      (progn
  (defmulti-method multi/-test 'rect (_ w h) (* w h))
  (defmulti-method multi/-test 'circle (_ r) (* float-pi (* r r)))
  (defmulti-method-fallback multi/-test (&rest _) 'unknown)
  (should (= 52 (multi/-test 'rect 4 13)))
  (should (= 28.274333882308138 (multi/-test 'circle 3)))
  (should (eql 'unknown (multi/-test 'sphere))))
    (reset-state)))

(ert-deftest multi/remove-method-should-delete-a-branch ()
  (defmulti multi/-test (a) a)
  (unwind-protect
      (progn
  (defmulti-method multi/-test 1 (a) a)
  (should (= 1 (multi/-test 1)))
  (multi-remove-method 'multi/-test 1)
  (should-error (multi/-test 1)))
    (reset-state)))


(ert-deftest multi/remove-method-fallback-should-remove-default-branch ()
  (defmulti multi/-test (a) a)
  (unwind-protect
      (progn
  (defmulti-method-fallback multi/-test (&rest _) 'unknown)
  (should (eql 'unknown (multi/-test 1)))
  (multi-remove-method-fallback 'multi/-test)
  (should-error (multi/-test 1)))
    (reset-state)))
