;; INCOMPLETE
(eval-when (:execute)
  (ql:quickload
   '(:serapeum :cl-ppcre :defpackage-plus :cl-oju :for :trivia.ppcre :series)))

(defpackage+-1:defpackage+ #:day5.gold
  (:use #:cl #:trivia #:series)
  (:import-from #:cl-oju #:slurp #:group-by)
  (:import-from #:trivia.ppcre #:ppcre)
  (:import-from #:serapeum #:op #:~> #:~>> #:->)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day5.gold)

(series::install)

(defstruct seed start end)
(defstruct material name src-start src-end dst-start dst-end range)

(defun input (filename &aux (content (slurp filename)))
  (multiple-value-call (op (values _ (group-by #'material-name _)))
    (gathering ((seeds collect) (materials collect))
      (dolist (line (s:lines (re:regex-replace-all "[:0-9]\\n" content " ")))
        (ematch line
          ((guard (ppcre "seeds: (.*)" ranges) (stringp ranges))
           (iterate (((x dt) (chunk 2 2 (scan (mapcar #'parse-integer (s:words ranges))))))
             (next-out seeds (make-seed :start x :end (1- (+ x dt))))))
          ((guard (ppcre "(.*)-to-(.*) map (.*)" c1 c2 ranges) (stringp ranges))
           (iterate (((dst src dt) (chunk 3 3 (scan (mapcar #'parse-integer (s:words ranges))))))
             (next-out materials (make-material
                                  :name c1
                                  :range dt
                                  :src-start src :src-end (1- (+ src dt))
                                  :dst-start dst :dst-end (1- (+ dst dt)))))))))))


(defgeneric intersects-p (seed in)
  (:method ((seed seed) (in material))
    (not (or (> (material-src-start in) (seed-end   seed))
             (< (material-src-end   in) (seed-start seed))))))

(defgeneric included-p (seed in)
  ;; (:method ((seed seed) (in material))
  ;;   (and (>= (seed-start seed) (material-src-start in))
  ;;        (<= (seed-end   seed) (material-src-end   in))))
  (:method ((seed seed) (in seed))
    (and (>= (seed-start seed) (seed-start in))
         (<= (seed-end   seed) (seed-end   in))))
  (:method ((seed seed) (in list))
    (position seed in :test #'included-p)))

(defun reduce-seeds (seeds)
  (loop :for seed :in (sort seeds #'< :key #'seed-start)
        :with dedup-seeds = ()
        :when (not (included-p seed dedup-seeds))
          :do (push seed dedup-seeds)
        :finally (return dedup-seeds)))
