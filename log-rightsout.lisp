;; ライツアウトの解法

(defvar *pattern* #(#x0000023 #x0000047 #x000008e #x000011c #x0000218
                    #x0000461 #x00008e2 #x00011c4 #x0002388 #x0004310
                    #x0008c20 #x0011c40 #x0023880 #x0047100 #x0086200
                    #x0118400 #x0238800 #x0471000 #x08e2000 #x10c4000
                    #x0308000 #x0710000 #x0e20000 #x1c40000 #x1880000))

(defun solve (board)
  (dotimes (i 32)
	(let ((new-board board) pushed-button)
	  ;; 1行目のボタンを押す
	  (dotimes (j 5)
		(when (logbitp j i)
		  (push j pushed-button)
		  (setq new-board (logxor new-board (aref *pattern* j)))))
	  ;; 1行ずつライトを消していく
	  (dotimes (j 20)
		(when (logbitp j new-board)
		  (push (+ j 5) pushed-button)
		  (setq new-board (logxor new-board (aref *pattern* (+ j 5))))))
	  ;; ライトが全部消えたか
	  (if (zerop new-board)
		  (print-answer (reverse pushed-button))))))

(defun print-answer (pushed-button)
  (dotimes (x 25 (terpri))
	(if (zerop (mod x 5)) (terpri))
	(cond ((and pushed-button
				(= x (car pushed-button)))
		   (princ "○")
		   (pop pushed-button))
		  (t (princ "×")))))

(solve #x1ffffff)
