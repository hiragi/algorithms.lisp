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
