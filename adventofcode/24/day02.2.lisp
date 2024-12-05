(ql:quickload '(defpackage-plus alexandria serapeum))

(defpackage+-1:defpackage+ #:day02
  (:use #:cl)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum)))

(in-package #:day02)

(defparameter *test* "data/day02.test.txt")
(defparameter *file* "data/day02.txt")

(defun parse (file)
  (flet ((line (s) (mapcar #'parse-integer (s:words s))))
    (s:~>> (a:read-file-into-string file)
           (s:lines)
           (mapcar #'line))))

(defun rule-1-p (record)
  "The levels are either all increasing or all decreasing."
  (and (or (equal (sort (copy-seq record) #'<) record)
           (equal (sort (copy-seq record) #'>) record))))

(defun rule-2-p (record)
  "Any two adjacent levels differ by at least one and at most three."
  (every
   (s:op (<= 1 (abs _) 3))
   (loop :for (a b) :on record
         :when (and a b)
           :collect (- a b))))

(defun part1 (file)
  (loop :for record :in (parse file)
        :counting (and (rule-1-p record)
                       (rule-2-p record))))

(defun part2 (file)
  (flet ((1-combinations (xs)
           (s:collecting
             (a:map-combinations #'collect xs :length (1- (length xs))))))
    (loop :for record :in (parse file)
          :counting
          (loop :for combination :in (1-combinations record)
                :thereis (and (rule-1-p combination)
                              (rule-2-p combination))))))
