;; 1から9までの数字を順番に並べ、間に +, - を補って100になる式を作りなさい。

;; 数式を組み立てる
(defun make-expr (n expr)
  (if (= n 10)
	  (check (reverse expr))
	(dolist (op '(+ - @))
	  (make-expr (1+ n) (cons n (cons op expr))))))

;; 計算して確かめる
(defun check (expr)
  (setq *expr* expr)
  (let ((num (get-first-number)))
	(while *expr*
	  (case (pop *expr*)
		(+ (incf num (get-number)))
		(- (decf num (get-number)))))
	(if (= num 100)
		(print expr))))

;; 最初の数値を取り出す
(defun get-first-number ()
  (cond ((integerp (car *expr*))
		 (get-number))
		((eq '- (car *expr*))
		 (pop *expr*)
		 (- (get-number)))))

;; 数値を取り出す
(defun get-number ()
  (let ((num (pop *expr*)))
	(while (eq '@ (car *expr*))
	  (pop *expr*)
	  (setq num (+ (* num 10) (pop *expr*))))
	num))

(make-expr 2 '(1))

(make-expr 2 '(1 -))
