;; クロージャの応用例として、ジェネレータを作る。
;; ジェネレータは呼び出されるたびに新しい値を生成する。
;; (ex) random関数
(defun make-gen-fib ()
  (let* ((a0 1) (a1 0) (a2 0)
		 (reset-func #'(lambda () (setq a0 1 a1 0 a2 0)))
		 (value-func #'(lambda () (prog1 a0
									(setq a2 a1 a1 a0)
									(setq a0 (+ a1 a2))))))
	#'(lambda (type)
		(cond ((eq type 'reset) (funcall reset-func))
			  ((eq type 'value) (funcall value-func))))))

(setq f1 (make-gen-fib))

(dotimes (x 5) (print (funcall f1 'value)))

(funcall f1 'reset)
