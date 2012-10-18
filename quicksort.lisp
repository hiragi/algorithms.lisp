(defun qsort (lst)
  (and lst
	   (let ((lst1) (lst2) (pv (car lst)))
			(multiple-value-setq (lst1 lst2)
			  (bunkaku (cdr lst) pv lst1 lst2))
			(append (qsort lst1)
					(cons pv (qsort lst2))))))

(defun bunkaku (lst pv lst1 lst2)
  (if (null lst)
	  (values-list (list lst1 lst2))
	(let ((a (car lst)))
	  (if (< a pv)
		  (bunkaku (cdr lst) pv (cons a lst1) lst2)
		(bunkaku (cdr lst) pv lst1 (cons a lst2))))))

(qsort '(8 6 5 1 9 2))


;; No.2
(defun quick-sort (f l)
  (unless (atom l)
	(let ((p (car l)) l1 l2)
	  (dolist (n (cdr l))
		(if (funcall f n p) (push n l1) (push n l2)))
	  (append (quick-sort f l1) (cons p (quick-sort f l2))))))

(quick-sort #'< '( 8 6 5 1 9 2))
