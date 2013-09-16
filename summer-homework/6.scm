; Justin Yang
; APCS Summer Homework #6

(define (odds lst)
	(odds-aux lst 0))

(define (odds-aux lst acc)
	(if (null? lst)
		acc
		(if (odd? (car lst))
			(odds-aux (cdr lst) (+ acc 1))
			(odds-aux (cdr lst) acc))))
