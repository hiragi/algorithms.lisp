(defun binary-search (item table)
  (let ((low 0) (high (1- (length table))) middle)
	(while (<= low high)
	  (setq middle (truncate (+ low high) 2))
	  (cond ((= (aref table middle) item)
			 ; Found
			 (return item))
			((< (aref table middle) item)
			 (setq low (1+ middle)))
			(t (setq high (1- middle)))))))

(setq a #(11 22 33 44 55 66 77 88 99))
(binary-search 44 a)
(binary-search 40 a)
