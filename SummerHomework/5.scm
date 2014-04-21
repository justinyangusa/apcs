; Justin Yang
; APCS Summer Homework #5

; (define (factorial n)
;	(if (= n 0)
;		1
;		(* n (factorial (- n 1)))))
;

(define (factorial n)
	(define (impl acc count)
		(if (= 0 count)
			acc
			(impl (* count acc) (- count 1))))
	(impl 1 n))

