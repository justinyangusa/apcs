; Justin Yang
; Paley APCS B Period
; Homework for 9/30-10/4

; Exercise 2.17

(define (last-pair lst)
  (cond ((null? (cdr lst)) (car lst))
        (else (last-pair (cdr lst)))))

; Exercise 2.18

(define (reverse lst)
  (cond ((null? lst) '())
        (else (append (reverse (cdr lst)) (list (car lst))))))

; Exercise 2.20

(define (same-parity-aux a b rem)
  (cond ((null? b) a)
        (else (same-parity-aux (cond ((= (remainder (car b) 2) rem)
                                      (append a (list (car b))))
                                     (else a))
                               (cdr b)
                               rem))))
(define (same-parity a . b)
  (same-parity-aux (list a) b (remainder a 2)))

; Exercise 2.21

(define nil '())

(define (square-list-1 items)
  (if (null? items)
      nil
      (cons (* (car items) (car items))
            (square-list-1 (cdr items)))))

(define (square-list-2 items)
  (map (lambda (x) (* x x)) items))

; Exercise 2.22

(define (square x) (* x x))

(define (square-list-a items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (square (car things))
                    answer))))
  (iter items nil))

; Louis takes the first element of the original list and places the
; square in front of the answer, which are sqaures of the
; preceding terms.

(define (square-list-b items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))

; This new version applies cons to the answer, which is a list,
; resulting in a series of nested lists.

; Exercise 2.23

(define (for-each proc lst)
  (proc (car lst))
  (cond ((not (null? (cdr lst))) (for-each proc (cdr lst)))))

; Exercise 2.24

(list 1 (list 2 (list 3 4))) ; (1 (2 (3 4)))

; Exercise 2.25

(car (cdr (car (cdr (cdr (list 1 3 (list 5 7) 9)))))) ; (1 3 (5 7) 9)

(car (car (list (list 7)))) ; ((7))

(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))))))))))))
; (1 (2 (3 (4 (5 (6 7))))))

; Exercise 2.26

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y) ; (1 2 3 4 5 6)

(cons x y) ; ((1 2 3) 4 5 6)

(list x y) ; ((1 2 3) (4 5 6))

; Exercise 2.27

(define (deep-reverse lst)
  (cond ((list? lst) (reverse (map deep-reverse lst)))
        (else lst)))

; Three Factors of Triangular Numbers (TFTN) Neato

(define (triangle x) (* x (+ x 1) (+ x 2)))
(define (sum n) (/ (* n (+ n 1)) 2))
(define NMAX 22736)

(define (neato n x res)
  (cond ((> n NMAX) res)
        ((> (triangle x) (sum n)) (neato (+ n 1) x res))
        ((= (triangle x) (sum n)) (neato (+ n 1) x (append res (list (list n x (sum n))))))
        (else (neato n (+ x 1) res))))

(neato 1 1 ())

; Extra credit: Exercise 2.19

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define first-denomination car)
(define except-first-denomination cdr)
(define no-more? null?)