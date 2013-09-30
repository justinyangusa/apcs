; Justin Yang
; Paley APCS B Period
; Homework for 9/23-9/27

; Exercise 2.1

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (make-rat n d)
  (cond ((< d 0) (cons (* -1 n) (* -1 d)))
        (else (cons n d))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (cond ((= (denom x) 0) (display "Division by zero"))
        (else
         (begin
           (display (numer x))
           (display "/")
           (display (denom x))))))

; Exercise 2.4

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

; Exercise 2.7

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))

(define (upper-bound x) (cdr x))

(define (lower-bound x) (car x))

; Exercise 2.8

(define (sub-interval x y)
  (add-interval x
                (make-interval (upper-bound y) (lower-bound y))))

; Exercise 2.9

(define (add-width a b c d)
  (- (upper-bound (add-interval (make-interval a b) (make-interval c d)))
     (lower-bound (add-interval (make-interval a b) (make-interval c d)))))

(define (get-width a b)
  (- (upper-bound (make-interval a b)) (lower-bound (make-interval a b))))

(add-width 667 899 272 314)
(+ (get-width 667 899) (get-width 272 314))

(define (sub-width a b c d)
  (- (upper-bound (sub-interval (make-interval a b) (make-interval c d)))
     (lower-bound (sub-interval (make-interval a b) (make-interval c d)))))

(sub-width 667 899 272 314)
(- (get-width 667 899) (get-width 272 314))

(define (mul-width a b c d)
  (- (upper-bound (mul-interval (make-interval a b) (make-interval c d)))
     (lower-bound (mul-interval (make-interval a b) (make-interval c d)))))

(mul-width 667 899 272 314)
(* (get-width 667 899) (get-width 272 314))

(define (div-width a b c d)
  (- (upper-bound (div-interval (make-interval a b) (make-interval c d)))
     (lower-bound (div-interval (make-interval a b) (make-interval c d)))))

(div-width 667 899 272 314)
(/ (get-width 667 899) (get-width 272 314) 1.)