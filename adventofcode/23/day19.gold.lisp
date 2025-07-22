;; INCOMPLETE
(eval-when (:execute)
  (ql:quickload '(:serapeum :cl-ppcre :defpackage-plus :trivia.ppcre :series)))

(defpackage+-1:defpackage+ #:day19.gold
  (:use #:cl #:trivia)
  (:import-from #:serapeum #:op)
  (:import-from #:trivia.ppcre #:split #:ppcre)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day19.gold)

(defstruct lesser  rating to action)
(defstruct greater rating to action)

(defun parse-action (rawaction)
  (a:switch (rawaction :test #'string=)
    ("A" :accept)
    ("R" :reject)
    (t   rawaction)))

(defun parse-rule (rawrule)
  (match rawrule ;; hdj{m>838:A,pv}
    ((guard (ppcre "([a-z]+)>([0-9]+):(.*)" r to a) (stringp to))
     (make-greater :rating r :to (parse-integer to) :action (parse-action a)))
    ((guard (ppcre "([a-z]+)<([0-9]+):(.*)" r to a) (stringp to))
     (make-lesser  :rating r :to (parse-integer to) :action (parse-action a)))
    (_ (parse-action rawrule))))

(defun parse-rules (rawrules)
  (mapcar #'parse-rule (re:split "," rawrules)))

(defun input (filename &aux (text (a:read-file-into-string filename)))
  (s:collecting
    (re:do-register-groups (name (#'parse-rules rules))
        ("([a-z]+){(.*)}" text)
      (collect (list name rules)))))

;;------------------------------

(defstruct range rating from to)

(defun range2count (range)
  (1+ (- (range-to range) (range-from range))))

(defmethod intersect (range (rules list))
  (mapcar (op (intersect range _)) rules))

(defmethod intersect (range rule)
  (match rule
    (:reject)
    (:accept (range2count range))
    ((guard (lesser rating (action :accept)) (equal rating (range-rating range)))
     (print rule))))

(defun intersect (range rules)
  )

(defun less-than (range n)
  (<= (range-from range) n (range-from range)))

(defun initial-ratings ()
  `(,(make-range :rating "x" :from 1 :to 4000)
    ,(make-range :rating "m" :from 1 :to 4000)
    ,(make-range :rating "a" :from 1 :to 4000)
    ,(make-range :rating "s" :from 1 :to 4000)))

(defun solve (workflows)
  (dolist (part (initial-parts))
    (loop :with (_ rules) = (s:assocadr "in" workflows)
          :while rules
          :do )))
