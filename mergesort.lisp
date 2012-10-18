(defun merge-list (f l1 l2)
  (cond
   ((atom l1) l2)
   ((atom l2) l1)
   ((funcall f (car l1) (car l2))
	(cons (car l1) (merge-list f (cdr l1) l2)))
   (t (cons (car l2) (merge-list f l1 (cdr l2))))))

(defun merge-sort (f l n)
  (cond
   ((= n 1) (list (car l)))
   ((= n 2)
	(let ((x (first l)) (y (second l)))
	  (if (funcall f x y) (list x y) (list y x))))
   (t (let ((m (truncate n 2)))
		(merge-list f
					(merge-sort f l m)
					(merge-sort f (nthcdr m l) (- n m)))))))

(merge-sort #'< '(9 2 1 8 6 3 7 5 4) 9)
