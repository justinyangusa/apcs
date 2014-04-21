; Justin Yang
; Paley APCS B Period
; Homework for 11/4-11/8

; Exercise 3.1

(define (make-accumulator value)
  (define balance value)
  (lambda (amount)
    (begin (set! balance (+ balance amount))
           balance)))

; Exercise 3.2

(define (make-monitored f)
  (define balance 0)
  (lambda (arg) (cond ((eq? arg 'how-many-calls?) balance)
                    ((eq? arg 'reset-counter) (set! balance 0))
                    (else (begin (set! balance (+ balance 1)) (f arg))))))
  

; Exercise 3.3

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch pass m)
    (cond ((not (eq? password pass)) (error "Incorrect password"))
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

; Exercise 3.7

(define (make-joint old-acc old-pwd new-pwd)
  (cond ((not (old-acc old-pwd 'deposit))
         (error "WRONG OLD PASSWORD"))
        (else (lambda (pass m)
                (cond ((eq? pass new-pwd) (old-acc old-pwd m))
                      (else (error "WRONG NEW PASSWORD")))))))

; Exercise 3.8

(define f
  (let ((first #t))
    (lambda (x)
      (cond (first (begin (set! first #f) x))
            (else (begin (set! first #t) 0))))))