;; その１
(defun solve (&optional (numbers '(1 2 3 4 5 6 7 8 9)) perm)
  (if numbers
	  (dolist (x numbers)
		(solve (remove x numbers) (cons x perm)))
	(check perm)))

(defun make-number (perm)
  (let ((value 0))
	(dotimes (x 3 value)
	  (setq value (+ (* value 10) (pop perm))))))

(defun check (perm)
  (let ((abc (make-number perm))
		(def (make-number (nthcdr 3 perm)))
		(ghi (make-number (nthcdr 6 perm))))
	(if (and (oddp abc)
			 (oddp def)
			 (oddp ghi)
			 (< abc def ghi)
			 (= (+ abc def ghi) 999))
		(format t "~D + ~D + ~D = 999~%" abc def ghi))))

;; その２(枝刈りver)
(defun solve-fast (&optional (n 0) (numbers '(1 2 3 4 5 6 7 8 9)) (value 0) num-list)
  (if numbers
	  (if (= n 3)
		  ; 数値がひとつ完成した
		  (if (and (oddp value)
				   (apply #'> value num-list))
			  (solve-fast 0 numbers 0 (cons value num-list)))
		; 数値を作っている途中
		(dolist (x numbers)
		  (solve-fast (1+ n) (remove x numbers) (+ (* value 10) x) num-list)))
	; 数値が3つ完成した
	(if (and (oddp value)
			 (apply #'> value num-list)
			 (= (apply #'+ value num-list) 999))
		(format t "~D + ~D + ~D = 999~%" (second num-list) (first num-list) value))))

(solve-fast)

;; その３(さらに枝刈り)
;; 2つの数値を生成する
(defun solve-very-fast (&optional (n 0) (numbers '(1 2 3 4 5 6 7 8 9)) (value 0) (abc 0))
  (if (= n 3)
	  (if (and (oddp value) (< abc value))
		  (if (plusp abc)
			  (check-fast abc value numbers)
			(solve-very-fast 0 numbers 0 value)))
	(dolist (x numbers)
	  (solve-very-fast (1+ n) (remove x numbers) (+ (* 10 value) x) abc))))

;; 小町算の条件を満たすかチェックする
(defun check-fast (abc def numbers)
  (let ((ghi (- 999 abc def)) n)
	(when (< def ghi)
	  (dotimes (x 3 (format t "~D + ~D + ~D = 999~%" abc def (- 999 abc def)))
		(setq n (mod ghi 10)
			  ghi (truncate ghi 10))
		(if (member n numbers)
			(setq numbers (remove n numbers))
		  (return))))))

(solve-very-fast)

