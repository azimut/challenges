(eval-when (:execute)
  (ql:quickload
   '(:serapeum :cl-ppcre :defpackage-plus :cl-oju :donuts)))

(defpackage+-1:defpackage+ #:day25.silver
  (:use #:cl)
  (:import-from #:cl-oju #:slurp)
  (:import-from #:serapeum #:op #:~> #:~>> #:-> #:lines #:filter)
  (:local-nicknames (#:a #:alexandria)
                    (#:s #:serapeum)
                    (#:re #:cl-ppcre)))

(in-package #:day25.silver)

(defun input (filename)
  (sort (~>> (slurp filename)
             (lines)
             (mapcar (op (remove-if #'a:emptyp (re:split "[: ]" _)))))
        #'<
        :key #'length))

(in-package #:donuts)

(defun node2donut (nodes &rest graph-opts)
  (apply #'in-donuts::make-graph
         (cons graph-opts
               (loop :for (head . edges) :in nodes
                     :appending (loop :for edge :in edges
                                      :collecting (-- head edge))))))

($ (:outfile "day25.silver.test.png")
   (node2donut (day25.silver::input "data/day25.test.txt")
               :layout :neato))

($ (:outfile "day25.silver.png")
   (node2donut (day25.silver::input "data/day25.txt")
               :layout :neato))
