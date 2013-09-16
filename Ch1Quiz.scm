; Justin Yang
; Paley APCS B Period
; Chapter 1 Quiz for 9/9-9/13

; Question 1

(define (factorial-aux n acc)
  (cond ((= n 0) acc)
        (else (factorial-aux (- n 1) (* acc n)))))

(define (factorial-1 n)
  (factorial-aux n 1))

; Question 2

(define (accumulate combiner null-value term a next b)
  (cond ((> a b) null-value)
        (else (combiner (term a)
                        (accumulate combiner null-value term (next a) next b)))))

(define (factorial-2 n)
  (accumulate * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) n))