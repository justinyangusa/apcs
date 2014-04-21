; Justin Yang
; APCS Summer Homework #8

(define (reverse lst)
	(reverse-aux lst '()))

(define (reverse-aux lst acc)
	(if (null? lst)
		acc
		(reverse-aux (cdr lst) (cons (car lst) acc))))
