#lang r5rs

; Re-use accumulate
(define (accumulate init acc args)
  (if (null? args)
      init
      (accumulate (acc (car args) init)     
                  acc
                  (cdr args))))

; Parameter list: my-plus 
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


; Mutability
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

(define immutable '(this list wont change))
(set-cdr! mutable immutable)
(set-car! (cdddr mutable) 'can)4

; Defining append!
(define (append! x y)
  (if (null? (cdr x))
      (set-cdr! x y)
      (append! (cdr x) y))
  x)      ;return x to mimic usual append behaviour

(define hello '(hello))
(define world '(world))
(display (append! hello world)) (newline)
(display hello)

; Mystery function
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

(define v '(a b c d))
(define w (mystery v))



(define (last x)
  (if (null? (cdr x))
      x
      (last (cdr x))))

(define (make-cycle x)
  (set-cdr! (last x) x) x)