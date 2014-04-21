; Justin Yang
; Paley APCS B Period
; Quiz 3 for 10/14-10/17

(define (reduce op lst)
  (cond ((null? (cdr lst)) (car lst))
        (else (reduce op (cons (op (car lst) (cadr lst)) (cddr lst))))))