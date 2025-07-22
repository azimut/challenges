;; INCOMPLETE
(eval-when (:execute)
  (ql:quickload '(:serapeum :cl-ppcre :defpackage-plus :rtg-math :cl-oju :for)))

(defpackage+-1:defpackage+ #:day22.silver
  (:use #:cl #:rtg-math)
  (:import-from #:cl-oju #:slurp)
  (:import-from #:serapeum #:op #:~> #:~>> #:->)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day22.silver)

(defstruct brick id a b height)

(defun bricks2levels (bricks &aux (max-z (apply #'max (mapcar #'z (mapcar #'brick-b bricks)))))
  (s:lret ((levels (make-array (1+ (floor max-z)) :initial-element nil)))
    (dolist (brick bricks)
      (push brick (aref levels (floor (z (brick-a brick))))))))

(defun input (filename &aux (id 0))
  (flet ((f (s) (destructuring-bind (x y z) (mapcar #'parse-integer (re:split "," s))
                  (v3!int x y z))))
    (bricks2levels
     (s:collecting
       (re:do-register-groups ((#'f from) (#'f to))
           ("(.*)~(.*)" (slurp filename))
         (let ((min-z (min (z from) (z to)))
               (max-z (max (z from) (z to))))
           (collect
             (make-brick
              :id (incf id)
              :a (if (< (z from) (z to)) from to); A is lower or equal than B
              :b (if (< (z from) (z to)) to from)
              :height (floor (- max-z min-z))))))))))

(defun collides-on-fall-p (falling-brick other-brick)
  (with-slots ((fa a) (fb b)) falling-brick
    (with-slots ((oa a) (ob b)) other-brick
      (let ((fminx (min (x fa) (x fb))) (fmaxx (max (x fa) (x fb)))
            (fminy (min (y fa) (y fb))) (fmaxy (max (y fa) (y fb)))
            (ominx (min (x oa) (x ob))) (omaxx (max (x oa) (x ob)))
            (ominy (min (y oa) (y ob))) (omaxy (max (y oa) (y ob))))
        (and (not (or (> fminx omaxx) (< fmaxx ominx)))
             (not (or (> fminy omaxy) (< fmaxy ominy)))
             (not (or (> (1- (z fa)) (z ob))
                      (< (1- (z fb)) (z oa)))))))))

(defun collide-levels (level level-below levels &aux (bricks-to-delete ()))
  (print (list level level-below))
  (dolist (brick (aref levels level))
    (loop :for brick-below :in (aref levels level-below)
          :for collide-p = (collides-on-fall-p brick brick-below)
          :until collide-p
          :finally (when (not collide-p)
                     (format t "bid=~d z=~d l=~d/~d~%" (brick-id brick) (z (brick-a brick)) level level-below)
                     (decf (z (brick-a brick)))
                     (decf (z (brick-b brick)))
                     (push brick (aref levels level-below))
                     (push (brick-id brick) bricks-to-delete))))
  (dolist (bid bricks-to-delete)
    (a:deletef (aref levels level) bid :key #'brick-id)))

(defun solve (levels)
  (print levels)
  (for:for ((level :ranging 2 (1- (array-dimension levels 0))))
    (for:for ((level-below :ranging 1 (1- level)))
      (collide-levels level level-below levels)))
  levels)
