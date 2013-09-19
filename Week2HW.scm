; Justin Yang
; Paley APCS B Period
; Homework for 9/3-9/6

; (require (lib "trace.ss")) (trace funt)

; Exercise 1.8

(define (cube x) (* x x x))

(define (cube-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-iter (improve guess x)
                 x)))

(define (improve guess x)
  (better x guess))

(define (better x y)
  (/ (+ (/ x (* y y)) (* 2 y)) 3))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (cbrt x)
  (cube-iter 1.0 x))

; Exercise 1.14 on paper

; Exercise 1.16

(define (expt-aux a b n)
  (cond ((= n 0) a)
        ((even? n) (expt-aux a (* b b) (/ n 2)))
        (else (expt-aux (* a b) b (- n 1)))))

(define (fast-expt b n)
  (expt-aux 1 b n))

; Extra credit: Exercise 1.19

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))     ; compute p'
                   (+ (* 2 p q) (* q q))   ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))