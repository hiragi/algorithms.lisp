(defmacro while (condition &body)
  `(do ()
	   ((not ,condition))
	 ,@body))
