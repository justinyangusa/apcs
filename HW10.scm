; Justin Yang & Ken Noh
; Paley B Period APCS
; Homework for 11/18-11/26

; Exercise 3.15
; Drawn on whiteboard

; Exercise 3.17
(define c (cons 1 2))
(define b (cons c c))
(define a (cons b b))	

(define (in? l e)
  (cond ((null? l) #f)
        ((eq? (car l) e) #t)
        (else (in? (cdr l) e))))

(define count-pairs
  (let ((visited '()))
    (lambda (x) (cond ((not (pair? x)) 0)
                      ((in? visited x) 0)
                      (else (begin (set! visited (cons x visited))
                             (+ (count-pairs (car x))
                                (count-pairs (cdr x))
                                1)))))))

(define a (list 1 2))
(set-car! a a)
(set-cdr! (cdr a) (cdr a))

; Exercise 3.20
; Drawn on whiteboard

; Exercise 3.22
(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (inqueue elem)
      (let ((new-pair (cons elem '())))
        (cond ((null? front-ptr) (set! front-ptr new-pair) (set! rear-ptr new-pair))
              (else (set-cdr! rear-ptr new-pair) (set! rear-ptr new-pair)))))
    (define (dequeue)
      (cond ((null? front-ptr) (error "null" elem))
            (else (set! front-ptr  (cdr front-ptr)) (car front-ptr))))
    (define (dispatch m)
      (cond ((equal? m 'inqueue) (lambda (x) (inqueue x)))
            ((equal? m 'dequeue) (lambda () (dequeue)))
            (else (error "error" m))))
    
    
    
    dispatch))

; Exercise 3.25

(define (make-general-table)
  (let ((local-table (cons '* ())))
    (define (lookup keys)
      (let ((subtable (cdr local-table))
            (counter ()))
        (define (lookup-h keys subtable)
          (set! counter (assoc (car keys) subtable))
          (cond ((null? (cdr keys)) (cdr record))
                (counter (lookup (cdr keys) (cdr subtable)))
                (else #f)))
        (lookup-h key-list subtable)))
      
    (define (insert! keys value)
      (if (lookup keys)
      
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch)))
(define (assoc key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))


; Exercise 3.27
; Drawn on whiteboard

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

; It computes the nth Fibonacci number in a number of steps proportional to n because it is using a table. By using a table, it will take order of n to look up the previously computed result in the table. Therefore, this procedure will take n-proportional steps in order to compute the current Fibonnaci term.
