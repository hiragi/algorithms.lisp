;; size of hash table
;; この値が素数だと安全である。
(defconstant *hash-size* 4001)

(defun hash-func (point)
  (let ((value 0))
	(dolist (x point (mod value *hash-size*))
	  (setq value (+ (* value 100) x)))))

;; store into hash table
(defun insert-hash (point hash-table)
  (let ((value (hash-func point)))
	(unless (find point (aref hash-table value) :test #'equal)
	  (push point (aref hash-table value)))))

;; create different n points
(defun make-data-fast (n)
  (let ((hash-table (make-array *hash-size*))
		(count 0) buffer point)
	(while (< count n)
	  (setq point (make-point))
	  (when (insert-hash point hash-table)
		(push point buffer)
		(incf count)))
	buffer))
