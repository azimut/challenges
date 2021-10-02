(defpackage #:lisperati-test
  (:use #:cl #:parachute))

(in-package #:lisperati-test)

(define-test numbers
  (of-type integer 5)
  (true (numberp 2/3))
  (false (numberp :keyword))
  (is-values (values 0 "1")
    (= 0)
    (equal "1")))
