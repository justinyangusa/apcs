; Justin Yang
; Paley APCS B Period
; Homework for 9/16-9/20

; Exercise 1.34

(define (f g)
  (g 2))

; When the interpreter calls (f f), it calls (f 2) which is not a procedure
; and ends up calling (2 2) which is an error.

; Exercise 1.41

(define (double f)
  (lambda (x) (f (f x))))

(define (inc n) (+ n 1))

(((double (double double)) inc) 5) ; 21

; Exercise 1.42

(define (compose f g)
  (lambda (x) (f (g x))))

; Exercise 1.43

(define (repeated f n)
  (cond ((= n 1) f)
        (else (compose f (repeated f (- n 1))))))