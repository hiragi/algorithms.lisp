(setf (get 'A 'adjacent) '(B C)
	  (get 'B 'adjacent) '(A C D)
	  (get 'C 'adjacent) '(A B E)
	  (get 'D 'adjacent) '(B E F)
	  (get 'E 'adjacent) '(C D G)
	  (get 'F 'adjacent) '(D)
	  (get 'G 'adjacent) '(E))

;; キューと幅優先探索
(defstruct Queue (front nil) (rear nil))

(defun enqueue (queue item)
  (let ((new-cell (list item)))
	(if (Queue-front queue)
		(setf (cdr (Queue-rear queue)) new-cell)
	  (setf (Queue-front queue) new-cell))
	(setf (Queue-rear queue) new-cell)))

(defun dequeue (queue)
  (if (Queue-front queue)
	  (prog1
		  (pop (Queue-front queue))
		(unless (Queue-front queue)
		  (setf (Queue-rear queue) nil)))))

(defun breadth-search (goal start)
  (let ((queue (make-Queue)) path)
	(enqueue queue (list start))
	(while (setq path (dequeue queue))
	  (dolist (node (get (car path) 'adjacent))
		(if (eq goal node)
			(print (reverse (cons node path)))
		  (unless (member node path)
			(enqueue queue (cons node path))))))))

(defmacro while (condition &body body)
  `(do ()
	   ((not ,condition))
	 ,@body))

(breadth-search 'G 'A)
