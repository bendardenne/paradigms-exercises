#lang r5rs

; Basics

(/ (* (+ 134 121)
      (/ 74 (sqrt 8)))
    (- 97.1
       (/ (exp 7) (* 78 71))))

(define a -8)

(define b
  (if (> a 0)
      (* 2 (sqrt a))
      (/ (* 7 (sqrt (- a))) (- a))))

(display b)

(define mypair (cons 'a  'b))
(display mypair)
(display (car mypair))	; -> Returns the symbol 'a
(display (cdr mypair))	; -> Returns the symbol 'b

(define mylist (cons 'a  '()))
(list? mylist) 	; -> returns #t, true

; Functions
(define (cube x) (* x x x))

; Recursion on numbers

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a)
         (sum-cubes (+ a 1) b))))

(sum-cubes 0 3)

(define (collatz? n)
  (display n)
  (newline)
  (cond ((equal? 1 n) #t)
        ((even? n) (collatz? (/ n 2)))
        (else (collatz? (+ (* n 3) 1)))))

; side-exercise

(define (my-even? x)
  (zero? (modulo x 2)))
(define (my-odd? x)
  (not (my-even? x)))

; Tail recursive
(define (sum-cubes-tail a b)
  ; hint: accumulate the result along the way in an additional variable
  (define (sum-cubes-iter a b sum)
    (if (> a b)
        sum
        (sum-cubes-iter (+ a 1) b (+ (cube a) sum))))
  (sum-cubes-iter a b 0))

; Recursion on lists

(define (how-many x l)
  (cond ((null? l) 0)
        ((equal? x (car l)) (+ 1 (how-many x (cdr l))))
        (else (how-many x (cdr l)))))

(define mylist '(1 4 7 3 a 1 3 4 8 9 2 1 a 4 6 a 0 3 4 9))
(how-many 3 mylist)
(how-many 'a mylist)
(how-many '() mylist)

(define (how-many-tail? x l)
  (define (how-many-iter x l ctr)
    (if (null? l)
        ctr
        (how-many-iter x
                       (cdr l)
                       (+ ctr
                          (if (= (car l) x)
                              1
                              0)))))
  (how-many-iter x l 0))

(define (duplicate l)
  (if (null? l) '()
        (append (list (car l) (car l)) (duplicate (cdr l)))))

(define (collatz-list n)
  (cond ((equal? 1 n) '(1))
      ((even? n) (cons n (collatz-list (/ n 2))))
      (else (cons n (collatz-list (+ (* n 3) 1))))))

