;; ベクタによるキューの実装

(defstruct Queue
  (front 0)
  (rear 0)
  (count 0)
  (buffer (make-array 16)))

(make-Queue :buffer (make-array 32))

(defun enqueue (queue data)
  (when (< (Queue-count queue) (array-total-size (Queue-buffer queue)))
	(setf (aref (Queue-buffer queue) (Queue-rear queue)) data)
	(incf (Queue-count queue))
	(incf (Queue-rear queue))
	(if (= (array-total-size (Queue-buffer queue)) (Queue-rear queue))
		(setf (Queue-rear queue) 0))
	t))

(setq a (make-array '(2 2)))

(array-total-size a)

(setq a (make-array 10 :fill-pointer 0))

(length a)

(array-total-size a)

(defun dequeue (queue)
  (when (plusp (Queue-count queue))
	(prog1
		(aref (Queue-buffer queue) (Queue-front queue))
	  (decf (Queue-count queue))
	  (incf (Queue-front queue))
	  (if (= (array-total-size (Queue-buffer queue)) (Queue-front queue))
		  (setf (Queue-front queue) 0)))))

(defun front (queue)
  (when (plusp (Queue-count queue))
	(aref (Queue-buffer queue) (Queue-front queue))))

(defun emptyp (queue) (zerop (Queue-count queue)))

(defun fullp (queue)
  (= (Queue-count queue) (array-total-size (Queue-buffer queue))))

(defun clear (queue)
  (setf (Queue-rear queue) 0
		(Queue-front queue) 0
		(Queue-count queue) 0))

(setq a (make-Queue))

(dotimes (x 16) (enqueue a x))

(enqueue a 100)

(while (not (emptyp a))
  (format t "~D " (dequeue a)))

