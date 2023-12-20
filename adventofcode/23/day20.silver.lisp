(eval-when (:execute)
  (ql:quickload '(:serapeum :cl-ppcre :defpackage-plus :trivia.ppcre :cl-oju)))

(defpackage+-1:defpackage+ #:day20.silver
  (:use #:cl #:trivia :trivia.ppcre)
  (:import-from :cl-oju :slurp)
  (:import-from :serapeum :lines :~> :~>> :href :op)
  (:local-nicknames (#:a #:alexandria) (#:s #:serapeum) (#:re #:cl-ppcre)))

(in-package #:day20.silver)

(defstruct broadcaster destinations)
(defstruct flip name (state :off) destinations)
(defstruct conj name (states (make-hash-table :test #'equal)) destinations)

(defun initialize-conj-modules (factory ifactory)
  (maphash (lambda (module-name input-module-names)
             (when (conj-p (href factory module-name))
               (mapc (lambda (_) (setf (href (conj-states (href factory module-name)) _)
                                  :low))
                     input-module-names)))
           ifactory))

(defun initialize-modules (lines factory ifactory)
  (dolist (line lines) ;; and button?
    (ematch line
      ((ppcre "broadcaster -> (.*)" ds) ;; broadcaster
       (let ((destinations (re:split ", " ds)))
         (mapc (lambda (_) (push "broadcaster" (href ifactory _))) destinations)
         (setf (href factory "broadcaster") (make-broadcaster :destinations destinations))))
      ((ppcre "%(.*) -> (.*)" name ds) ;; flip
       (let ((destinations (re:split ", " ds)))
         (mapc (lambda (_) (push name (href ifactory _))) destinations)
         (setf (href factory name) (make-flip :name name :destinations destinations))))
      ((ppcre "&(.*) -> (.*)" name ds) ;; conj
       (let ((destinations (re:split ", " ds)))
         (mapc (lambda (_) (push name (href ifactory _))) destinations)
         (setf (href factory name) (make-conj :name name :destinations destinations)))))))

(defun input (filename &aux (lines (~>> filename slurp lines)))
  (s:lret ((ifactory (make-hash-table :test #'equal));; inverse, stores modules to input modules lists
           (factory (make-hash-table :test #'equal)))
    (initialize-modules lines factory ifactory)
    (initialize-conj-modules factory ifactory)))

(defun enq-all (source-name destinations queue pulse)
  (mapc (op (s:enq `(,source-name ,pulse ,_) queue)) destinations))

(defmethod receive (module pulse source-name queue))

(defmethod receive :before (module pulse source-name queue)
  #+nil
  (format t "~a -~a-> ~a~%" source-name pulse
          (match module
            ((broadcaster) "broadcaster")
            ((conj name) name)
            ((flip name) name)
            (_ module))))

(defmethod receive ((module string) pulse source-name queue));; dead end module

(defmethod receive ((module broadcaster) pulse source-name queue)
  (enq-all "broadcaster" (broadcaster-destinations module) queue pulse))

(defmethod receive ((module flip) (pulse (eql :low)) source-name queue &aux output-pulse)
  (ecase (flip-state module)
    (:on  (setf (flip-state module) :off output-pulse :low))
    (:off (setf (flip-state module) :on  output-pulse :high)))
  (enq-all (flip-name module) (flip-destinations module) queue output-pulse))

(defmethod receive ((module conj) pulse source-name queue)
  (setf (href (conj-states module) source-name) pulse)
  (enq-all (conj-name module) (conj-destinations module) queue
           (if (every (op (eql :high _)) (a:hash-table-values  (conj-states module)))
               :low
               :high)))

(defun solve (factory &aux (queue (s:queue))
                           (count-high 0)
                           (count-low 0))
  (dotimes (i 1000)
    (s:enq `("button" :low "broadcaster") queue)
    (loop :until (s:queue-empty-p queue)
          :for (source-name pulse destination-name) = (s:deq queue)
          :for module = (or (href factory destination-name) destination-name)
          :do (receive module pulse source-name queue)
              (case pulse
                (:low (incf count-low))
                (:high (incf count-high)))))
  (* count-low count-high))
