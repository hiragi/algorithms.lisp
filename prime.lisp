(defun primep (n)
  (primep2 n 2 (truncate (sqrt n))))


;(defun primep2 (n k end)
;  (if (> k end)
;	  t
;	(if (= (mod n k) 0)
;		nil
;	  (prime2 n (1+ k) end))))

(defun primep2 (n k end)
  (or (> k end)
	  (and (> (mod n k) 0) (primep2 n (1+ k) end))))

(defun get10prime ()
  (let ((count 0) (n 10000) (result))
	(while (< count 10)
	  (and (primep n)
		   (setq result (cons n result))
		   (setq count (1+ count)))
	  (setq n (1- n)))
	result))

(get10prime)
