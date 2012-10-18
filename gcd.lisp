(defun mygcd (m n)
  (let ((r (mod m n)))
	(if (= r 0)
		n
	  (mygcd n r))))

(mygcd 512 252)
