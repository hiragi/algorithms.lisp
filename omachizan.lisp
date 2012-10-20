;; 大町算
;; 0から9までの10個の数値を１つずつ使った計算
;; ある連続した3数を掛け合わせたら、大町数になったという。そのような3数をすべて
;; みつける。

;; 最初に整数nの範囲を絞り込みます。大町数の最大値は9876543210で最小値は1023456789
;; だから、nの値は次の範囲内になる。
(expt 1023456789 1/3)
(* 1006 1007 1008)

(expt 9876543210 1/3)
(* 2145 2146 2147)

;; nは1007以上2144以下であることがわかる。あとは単純に計算して大町数になるか確認
(defun solve ()
  (do ((n 1007 (1+ n)))
	  ((> n 2144))
	(check n (1+ n) (+ n 2))))
(defun check (n1 n2 n3)
  (let ((value (* n1 n2 n3)) numbers)
	(dotimes (x 10 (format t "~D * ~D * ~D = ~D~%" n1 n2 n3 (* n1 n2 n3)))
	  (multiple-value-bind
		  (q r)
		  (truncate value 10)
		(if (member r numbers) (return))
		(push r numbers)
		(setq value q)))))

(solve)
