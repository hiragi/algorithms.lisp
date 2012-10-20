;; リストによるキューの実装
(defstruct Queue (front nil) (rear nil))

(defun enqueue (queue item)
  (let ((new-cell (list item)))
	(if (Queue-front queue)
		;; 最終セルを書き換える
		(setf (cdr (Queue-rear queue)) new-cell)
	  ;; キューは空の状態
	  (setf (Queue-front queue) new-cell))
	(setf (Queue-rear queue) new-cell)))

(defun dequeue (queue)
  (if (Queue-front queue)
	  (prog1
		  (pop (Queue-front queue))
		(unless (Queue-front queue)
		  (setf (Queue-rear queue) nil)))))

(setq *q* (make-Queue))
(dotimes (x 5) (enqueue *q* x))
*q*
(dotimes (x 5) (print (dequeue *q*)))
