(defun pack (ls)
  (labels ((foo (ls0 ls1 ls2)
				(let ((x (car ls0))
					  (y (car ls1)))
				  (cond
				   ((null ls0)
					(cdr (reverse (cons ls1 ls2))))
				   ((eql x y)
					(foo (cdr ls0) (cons x ls1) ls2))
				   (t
					(foo (cdr ls0) (cons x nil) (cons ls1 ls2)))))))
	(foo ls '() '())))

(pack '(A B B A A B B B A C C A))
