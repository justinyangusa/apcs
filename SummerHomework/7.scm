; Justin Yang
; APCS Summer Homework #7

(define (filter pred lst)
	(cond ((null? lst) '())
		((pred (car lst))
		 (cons (car lst) (filter pred (cdr lst))))
		(else (filter pred (cdr lst)))))
