(defmacro define (args-list &rest body)
  `(defun ,(car args-list) ,(cdr args-list) ,@body))

(define (foo x y) (+ x y))
(foo 3 4)

;; 分配を用いたdefineマクロ
(defmacro define ((name &rest args) &rest body)
  `(defun ,name ,args ,@body))
