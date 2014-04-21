; Justin Yang
; Paley APCS B Period
; Homework for 10/7-10/17

(require (lib "trace.ss"))

(define nil '())

(define (square x) (* x x))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

; Exercise 2.29

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; Part (a)

(define left-branch car)
(define right-branch cadr)

(define branch-length car)
(define branch-structure cadr)

(define weight? number?)
(define mobile? pair?)

; Part (b)

(define (branch-weight b)
  (cond ((mobile? (branch-structure b)) (total-weight (branch-structure b)))
        (else (branch-structure b))))

(define (total-weight m)
  (+ (branch-weight (left-branch m))
     (branch-weight (right-branch m))))

; Part (c)

(define (torque b)
  (* (branch-weight b) (branch-length b)))

(define (balanced? m)
  (or (weight? m)
      (and (= (torque (left-branch m))
              (torque (right-branch m)))
           (balanced? (branch-structure (left-branch m)))
           (balanced? (branch-structure (right-branch m))))))

; Part (d)

(define (make-mobile-cons left right)
  (cons left right))
(define (make-branch-cons length structure)
  (cons length structure))

(define right-branch cdr) ; just cdr and not cadr
(define branch-structure cdr) ; just cdr and not cadr
; The rest of the code is written so that there is no knowledge of the data structures.


; Exercise 2.30

(define (square-tree lst)
  (cond ((null? lst) '())
        ((number? lst) (* lst lst))
        (else (cons (square-tree (car lst)) (square-tree (cdr lst))))))

(define (square-tree-map lst)
  (map (lambda (x) (cond ((null? x) '())
                         ((not (pair? x)) (* x x))
                         (else (square-tree-map x))))
       lst)) 

; Exercise 2.31

(define (tree-map proc tree)
   (cond ((null? tree) '())
         ((pair? tree) (cons (tree-map proc (car tree))
                             (tree-map proc (cdr tree))))
         (else (proc tree))))

(define (square-tree2 tree) (tree-map square tree))

; Exercise 2.32

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (term) (cons (car s) term)) rest)))))

; The first element of the list is removed from the list and added to each of the
; subsets of the cdr of the list. Since each of the subsets can either have or not
; have the car of the list, the subsets without the car and the ones with the car are
; appended together.

; Exercise 2.33

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(define (length sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))

; Exercise 2.35

(define (count-leaves t)
  (accumulate + 0 (map (lambda (t) (cond ((not (pair? t)) 1)
                                         (else (count-leaves t))) t))))