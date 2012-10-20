;
; nim.l : 三山くずし
;
;         Copyright (C) 2002 Makoto Hiroi
;

;; 乱数の初期化
(setq *random-state* (make-random-state t))

;; 三山を作る
(defun make-nim ()
  (let (buffer)
	(dotimes (x 3 buffer)
	  (push (1+ (random 10)) buffer))))

;; 指し手の入力
(defun input-position (nim)
  (let (pos num)
	(loop
	 (format t "~%Input Position (0 - 2) > ")
	 (setq pos (read))
	 (when (<= 0 pos 2)
	   (format t "~%Input Numbers (1 - ~D) > " (nth pos nim))
	   (setq num (read))
	   (if (and (plusp num) (<= num (nth pos nim)))
		   (return (values pos num))))
	 (format t "~%Error"))))

;; 石が一番多い山を求める
(defun max-position (nim)
  (let ((num -1) pos)
	(dotimes (x 3 (values pos 1))
	  (if (< num (nth x nim))
		  (setq pos x
				num (nth x nim))))))

;; ニム和が0になる指し手を求める
(defun safe-position (nim)
  (let ((nim-sum (apply #'logxor nim)) num)
	(dotimes (x 3)
	  (setq num (- (nth x nim) (logxor (nth x nim) nim-sum)))
	  (if (plusp num)
		  (return (values x num))))))

(defun remove-stone-sub (x nim pos num)
  (if (= x pos)
	  (cons (- (car nim) num) (cdr nim))
	(cons (car nim) (remove-stone-sub (1+ x) (cdr nim) pos num))))

(defun remove-stone (nim pos num)
  (format t "~D から ~D 個を取ります~%" pos num)
  (remove-stone-sub 0 nim pos num))

;; コンピュータの指し手
(defun move-com (nim)
  (format t "~%~S 私の番です~%" nim)
  (multiple-value-bind
	  (pos num)
	  (if (zerop (apply #'logxor nim))
		  (max-position nim)
		(safe-position nim))
	(remove-stone nim pos num)))

;; プレーヤーの指し手
(defun move-human (nim)
  (format t "~%~S あなたの手番です~%" nim)
  (multiple-value-bind
	  (pos num)
	  (input-position nim)
	(remove-stone nim pos num)))

;; ゲームの実行
(defun nim-game ()
  (let ((nim (make-nim)) (turn 0))
	(loop
	 (if (oddp turn)
		 (setq nim (move-com nim))
	   (setq nim (move-human nim)))
	 (when (equal nim '(0 0 0))
	   (format t "~Aのかちです~%" (if (oddp turn) "私" "あなた"))
	   (return))
	 (incf turn))))

(nim-game)
