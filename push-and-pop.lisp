(defmacro my-push (item lst)
  (list 'setq
		lst
		(list 'cons item lst)))

(setq a '(a))
(my-push 'aa a)

(defmacro my-pop (lst)
  (list 'prog1
		(list 'car lst)
		(list 'setq
			  lst
			  (list 'cdr lst))))

(my-pop a)

(macroexpand-1 '(my-pop a))

;; version 2

(defmacro my-push (item place)
  `(setq ,place (cons ,item ,place)))

(defmacro my-pop (place)
  `(prog1
	   (car ,place)
	 (setq ,place (cdr ,place))))
