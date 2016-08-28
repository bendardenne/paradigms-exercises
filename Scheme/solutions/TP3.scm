#lang r5rs

; Re-use accumulate
(define (accumulate init acc args)
  (if (null? args)
      init
      (accumulate (acc (car args) init)     
                  acc
                  (cdr args))))


(define (my-plus . c)
  (apply accumulate (list 0 + c)))


; Scoping 
(let ((x 10)) (let ((y x)) (display (* x y))))

(define x 1)
(define (f x) (g 2))
(define (g y) (+ x y))
(f 5)   

(let ((a 5)) (let ((fun (lambda (x) (max a x))))
               (let ((a 10) (x 20))
                 (fun 1))))

(define mutable (list 1 2 4 2 57 9 .1 3 12 -75))
(map (lambda (x) (/ (sqrt x) x)) mutable)

(newline)
(display mutable) (newline)

(set-car! mutable 20)
(display mutable) (newline)

(set-car! (cdr mutable) 10)
(display mutable) (newline)

(set-cdr! (cdr mutable) '(just changing my cdr)) 
(display mutable) (newline)

(set-cdr! mutable mutable)
(display mutable) (newline)

(define (last x)
  (if (null? (cdr x))
      x
      (last (cdr x))))

(define (make-cycle x)
  (set-cdr! (last x) x) x)

(define immutable '(this list wont change))
(set-cdr! mutable immutable)
(set-car! (cdddr mutable) 'can)