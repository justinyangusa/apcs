; Justin Yang
; Paley APCS B Period
; Homework for 8/26-8/30

; Exercise 1.1

10 ; 10
(+ 5 3 4) ; 12
(- 9 1) ; 8
(/ 6 2) ; 3
(+ (* 2 4) (- 4 6)) ; 6
(define a 3); prints nothing
(define b (+ a 1)); prints nothing
(+ a b (* a b)) ; 19
(= a b); #f
(if (and (> b a) (< b (* a b))) ; 4
    b
    a)
(cond ((= a 4) 6) ; 16
      ((= b 4) (+ 6 7 a))
      (else 25))
(+ 2 (if (> b a) b a)) ; 6
(* (cond ((> a b) a) ; 16
         ((< a b) b)
         (else -1))
   (+ a 1))

; Exercise 1.2

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))

; Exercise 1.3

(define (large-sum x y z)
  (cond ((and (> x y) (> y z)) (+ (* x x) (* y y)))
        ((and (> x y) (>= z y)) (+ (* x x) (* z z)))
        ((and (>= y x) (> x z)) (+ (* x x) (* y y)))
        (else (+ (* y y) (* z z)))))

; Exercise 1.4

(define (a-plus-abs-b a b) ; applies operator +/- depending on b > 0
  ((if (> b 0) + -) a b))

; Exercise 1.5

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

; (test 0 (p))

; For an applicative-order interpreter, Ben calls (test 0 (p))
; and the interpreter expands to (test 0 (p)) according to the
; definition so that the evaluation never terminates.
;
; For a normal-order interpreter, Ben calls (test 0 (p)) and gets
; (test 0 (p))
; (if (= 0 0)
;     0
;     (p))
; 0

; Exercise 1.6

(define (square x) (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; The Scheme interpreter uses applicative-order evaluation so that
; the else statement is always evaluated under new-if, resulting
; in a non-terminating call.