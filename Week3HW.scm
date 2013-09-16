; Justin Yang
; Paley APCS B Period
; Homework for 9/9-9/13

; Exercise 1.30

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

; Exercise 1.31(a)

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial n)
  (product (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

(define (pi-prod n)
  (/ (* 8. (product (lambda (x) (* (* 2 x) (* 2 x)))
                    2
                    (lambda (x) (+ x 1))
                    n))
     (* (product (lambda (x) (* (- (* 2 x) 1) (- (* 2 x) 1)))
                 2
                 (lambda (x) (+ x 1))
                 n)
        (+ (* 2 n) 1))))

; Exercise 1.32(a)

(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (cond ((> a b) result)
          (else (iter (next a) (combiner (term a) result)))))
  (iter a null-value))

(define (acc-sum term a next b) (accumulate + 0 term a next b))

(define (acc-prod term a next b) (accumulate * 1 term a next b))

; Exercise 1.32

(define (filtered-accumulate combiner null-value term a next b filter)
  (define (iter a result)
    (cond ((> a b) result)
          (else (iter (next a)
                      (cond ((filter a) (combiner (term a) result))
                            (else result))))))
  (iter a null-value))

(define (sum-odds a b)
  (filtered-accumulate + 0 (lambda (x) x) a (lambda (x) (+ x 1)) b odd?))