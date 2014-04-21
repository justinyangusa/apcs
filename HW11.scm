; Justin Yang & Ken Noh
; Paley B Period APCS
; Homework for 11/25-12/6

; The delete! problem

(define (make-table)
  (cons '* ()))
(define (empty-table? t) (null? (cdr t)))

(define (insert! key value table)
  (let ((new-node (cons key value)))
    (let ((new-ptr (cons new-node ())))
      (set-cdr! new-ptr (cdr table))
      (set-cdr! table new-ptr))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value) (cdr table)))))
  'ok)

        
(define (lookup k t)
  (let ((record (assoc k (cdr t))))
    (cond (record (cdr record))
          (else #f))))
(define (assoc key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (rlookup k t)
  (let ((record (rassoc k (cdr t))))
    (cond (record (car record))
          (else #f))))
(define (rassoc value records)
  (cond ((null? records) #f)
        ((equal? value (cdar records)) (car records))
        (else (rassoc value (cdr records)))))

(define (delete! k t)
  (cond ((not (pair? t)) 'ok)
        ((null? (cdr t)) 'ok)
        ((equal? k (caadr t)) (set-cdr! t (cddr t)))
        (else (delete! k (cdr t)))))