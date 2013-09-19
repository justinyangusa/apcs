; Justin Yang
; Paley APCS B Period
; Chapter 2 Quiz for 9/16-9/20

(define (quadratic a b c)
  (cond ((or (= a 0) (< (- (* b b) (* 4 a c)) 0)) '())
        ((= (- (* b b) (* 4 a c)) 0) (list (/ (* -1 b) 2 a)))
        ((< (- (* b b) (* 4 a c)) 0) '((/ (- (sqrt (- (* b b) (* 4 a c))) b) 2 a) (/ (+ (sqrt (- (* b b) (* 4 a c))) b) -2 a)))))