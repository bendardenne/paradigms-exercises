;;; 3.3 Modeling with Mutable Data

;;; 3.3.1 Mutable List Structure

(define (cons x y)
  (let ((new (get-new-pair)))
    (set-car! new x)
    (set-cdr! new y)
    new))

;; EXERCISE 3.12

(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

(define (append! x y)
  (set-cdr! (last x) y)
  x)

(define (last x)
  (if (null? (cdr x))
      x
      (last (cdr x))))

>>> (define x '(a b))
x
>>> (define y '(c d))
y
>>> (define z (append x y))
z
>>> z
(a b c d)
>>> (cdr x)
(b)
>>> (define w (append! x y))
w
>>> w
(a b c d)
>>> (cdr x)
(b c d)


;; EXERCISE 3.13

(define (make-cycle x)
  (set-cdr! (last x) x)
  x)

(define z (make-cycle '(a b c)))

>>> (last z)
=> de interpreter blijft oneindig lang bezig
                                       
>>> z
(a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a b c a ... enz... )

                                                                                                                                                                                 
;; EXERCISE 3.14

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

>>> (define v '(a b c d))
v
>>> (define w (mystery v))
w
>>> w
(d c b a)
>>> v
(a)


;;; Sharing and identity

(define (set-to-wow! x)
  (set-car! (car x) 'wow)
  x)

;; EXERCISE 3.16

(define (count-pairs x)
  (if (atom? x)
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

; Voorbeeld 1 : Aantal pairs = 3 , en count-pairs = 3
>>> (define voorbeeld1 '(a b c))
voorbeeld1
>>> voorbeeld1
(a b c)
>>> (count-pairs voorbeeld1)
3

; Voorbeeld 2 : Aantal pairs = 3 , en count-pairs = 4
>>> (define x '(b))
x
>>> x
(b)
>>> (define y (cons x x))
y
>>> y
((b) b)
>>> (define voorbeeld2 (cons 'a y))
voorbeeld2
>>> voorbeeld2
(a (b) b)
>>> (count-pairs voorbeeld2)
4

; Voorbeeld 3 : Aantal pairs = 3 , en count-pairs = 7
>>> (define x '(b))
x
>>> x
(b)
>>> (define y (cons x x))
y
>>> y
((b) b)
>>> (define voorbeeld3 (cons y y))
voorbeeld3
>>> voorbeeld3
(((b) b) (b) b)
>>> (count-pairs voorbeeld3)
7

; Voorbeeld 4 : Aantal pairs = 3 , en count-pairs stopt nooit                                                                         
>>> (define voorbeeld4 (make-cycle '(a b c)))
    -> oneidige lus (zie oefening 3.13)

                    
;; EXERCISE 3.17

(define (count-pairs structure)
  (define counted-pairs-list '())
  (define first structure)
  (letrec 
    ((count-distinct-pairs 
      (lambda (current-pair)
        (let ((already-counted? (lambda (pair)
                                  (memq pair counted-pairs-list))))
          (let ((add-current (if (already-counted? current-pair)
                                 0
                                 (begin
                                  (set! counted-pairs-list
                                    (cons current-pair counted-pairs-list))
                                  1))))
            (if (or (atom? current-pair) (eq? current-pair first))
                0
                (+ (count-distinct-pairs (car current-pair))
                   (count-distinct-pairs (cdr current-pair))
                   add-current)))))))
    (count-distinct-pairs structure)))

; Als we met deze versie kijken naar voorbeeld1, voorbeeld2, voorbeeld3 en
; voorbeeld4 uit vorige oefening vinden we :

>>> (count-pairs voorbeeld1)
3
>>> (count-pairs voorbeeld2)
3
>>> (count-pairs voorbeeld3)
3
>>> (count-pairs voorbeeld4)
=> interpreter blijft oneindig lang bezig ...
 
; Deze versie werkt dus exact voor willekeurige structuren, zolang het geen
; lussen zijn. Dit geval kan echter ook opgelost worden, op de volgende
; manier : 

(define (count-pairs structure)
  (define counted-pairs-list '())
  (define first structure)
  (define counter 0)
  (letrec 
    ((count-distinct-pairs 
      (lambda (current-pair)
        (let ((already-counted? (lambda (pair)
                                  (memq pair counted-pairs-list))))
          (let ((add-current (if (already-counted? current-pair)
                                 0
                                 (begin
                                  (set! counted-pairs-list
                                    (cons current-pair counted-pairs-list))
                                  1))))
            (set! counter (add1 counter))
            (if (or (atom? current-pair) 
                    (and (> counter 1) (eq? current-pair first)))
                0
                (+ (count-distinct-pairs (car current-pair))
                   (count-distinct-pairs (cdr current-pair))
                   add-current)))))))
    (count-distinct-pairs first)))

; Verklaring : behalve dat we gaan testen of we een paar al tegengekomen 
; zijn of niet, gaan we nu ook testen of het paar dat we tegenkomen niet
; het eerste paar van de cyclus is waarmee we zijn begonnen. Zo ja, dan
; stoppen we. Natuurlijk moeten we dan ook een counter bijhouden, omdat
; deze test pas mag beginnen vanaf de tweede stap, aangezien in de eerste
; stap vanzelfsprekend het eerste paar wordt getest (en anders zou het
; algoritme al stoppen bij de eerste stap.)  

>>> (count-pairs voorbeeld1)
3
>>> (count-pairs voorbeeld2)
3
>>> (count-pairs voorbeeld3)
3
>>> (count-pairs voorbeeld4)
3
                                          
                                          
;; EXERCISE 3.18                                                                                                                        

(define (cycle? list)
  (define first list)
  (define counter 0)
  (letrec 
    ((cycleer (lambda (current-pair)
                (set! counter (add1 counter))
                (cond 
                 ((atom? current-pair) 'no-cycle)
                 ((and (> counter 1) (eq? current-pair first))
                  'cycle)
                 (else (begin
                        (cycleer (car current-pair))
                        (cycleer (cdr current-pair))))))))
    (cycleer first)))

>>> (cycle? voorbeeld1)
no-cycle      
>>> (cycle? voorbeeld2)
no-cycle
>>> (cycle? voorbeeld3)
no-cycle
>>> (cycle? voorbeeld4)
cycle


;;; Mutation is just assignment

(define (cons x y)
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          (else (error "Undefined operation -- CONS" m))))
  dispatch)

(define (car z) (z 'car))

(define (cdr z) (z 'cdr))

(define (cons x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eq? m 'car) x)
          ((eq? m 'cdr) y)
          ((eq? m 'set-car!) set-x!)
          ((eq? m 'set-cdr!) set-y!)
          (else error "Undefined operation -- CONS" m)))) 

(define (car z) (z 'car))

(define (cdr z) (z 'cdr))

(define (set-car! z new-value)
  ((z 'set-car!) new-value)
  z)

(define (set-car! z new-value)
  ((z 'set-cdr!) new-value)
  z)


;;; 3.3.2 Representing Queues

(define (front-ptr queue) (car queue))

(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))

(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "Delete called with an empty queue" queue))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         queue)))


;; EXERCISE 3.21

>>> (define q1 (make-queue))
q1
>>> (insert-queue! q1 'a)
((a) a)
>>> (insert-queue! q1 'b)
((a b) b)
>>> (delete-queue! q1)
((b) b)
>>> (delete-queue! q1)
(() b)

; Verklaring van deze resultaten :

>>> (define q1 (make-queue))
q1
>>> q1
(())

; Een niewe queue bestaat uit een lijst met front-ptr (= car van de lijst)
; gelijk aan de lege lijst '() en next-ptr (= cdr van de lijst) ook gelijk
; aan de lege lijst. M.a.w. q1 = (cons '() '()) = (()) 

>>> (insert-queue! q1 'a)
((a) a)

; Als we een element 'a toevoegen aan de lege queue maken we van dit nieuwe
; element een paar (cons 'a '()) = (a) en laten we zowel de front-ptr als de
; rear-ptr van de queue naar dit paar verwijzen.
; M.a.w. q1 = (cons '(a) '(a)) = ((a) a)

>>> (insert-queue! q1 'b)
((a b) b)

; Wanneer we nu nog een extra element 'b toevoegen, maken we een nieuw paar
; (cons 'b '()) = (b) en hangen dit achteraan de lijst '(a) die we reeds 
; hadden. Bovendien wordt '(b) dan het einde van de lijst en moet de 
; rear-ptr dus hiernaar verwijzen. Zo krijgen we dus : ((a b) b)

>>> (delete-queue! q1)
((b) b)

; Bij een delete wordt het eerste element uit de queue gehaald. De 
; verwijzing naar het laatste element verandert dus niet, dus de rear-ptr 
; blijft ongewijzigd. Het eerste element van de queue moet echter weggeknipt 
; worden. Zodoende verandert ((a b) b) in ((b) b)

>>> (delete-queue! q1)
(() b)

; Bij een delete wordt het eerste element uit de queue gehaald. De 
; verwijzing naar het laatste element verandert dus niet, dus de rear-ptr 
; blijft ongewijzigd. Het eerste element van de queue moet echter weggeknipt 
; worden. Zodoende verandert ((b) b) in (() b)

; Afdrukken van een queue :

(define (print-queue queue)
  (front-ptr queue))


;; EXERCISE 3.22

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty?)
      (null? front-ptr))
    (define (insert item)
      (let ((new-pair (cons item '())))
        (if (empty?)
            (begin
             (set! rear-ptr new-pair)
             (set! front-ptr new-pair))
            (begin
             (set-cdr! rear-ptr new-pair)
             (set! rear-ptr new-pair)
             front-ptr))))
    (define (dispatch m)
      (cond ((eq? m 'empty?)
             (empty?))
            ((eq? m 'front)
             (if (empty?)
                 (error "FRONT called with an empty queue")
                 (car front-ptr)))
            ((eq? m 'insert)
             insert)
            ((eq? m 'delete)
             (if (empty?)
                 (error "DELETE called with an empty queue")
                 (set! front-ptr (cdr front-ptr))))
            (else (error "Undefined operation -- MAKE-QUEUE"))))
    dispatch))

(define (empty-queue? queue)
  (queue 'empty?))

(define (front queue)
  (queue 'front))

(define (insert-queue! queue item)
  ((queue 'insert) item))

(define (delete-queue! queue)
  (queue 'delete))

(define (print-queue queue)
  (queue 'print))

; Voorbeeld :

>>> (define q1 (make-queue))
q1
>>> (insert-queue! q1 'a)
(a)
>>> (insert-queue! q1 'b)
(a b)
>>> (print-queue q1)
(a b)
>>> (delete-queue! q1)
(b)
>>> (delete-queue! q1)
()


;; EXERCISE 3.23

(define (make-deque)
  (cons '() '()))

(define (front-ptr deque) (car deque))

(define (set-front-ptr! deque item) (set-car! deque item))

(define (rear-ptr deque) (cdr deque))

(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (previous deque-node)
  (caar deque-node))

(define (set-previous! deque-node previous-node)
  (set-car! (car deque-node) previous-node))

(define (next deque-node)
  (cdr deque-node))

(define (set-next! deque-node next-node)
  (set-cdr! deque-node next-node))

(define (value deque-node)
  (cdar deque-node))

(define (empty-deque? deque)
  (and (null? (front-ptr deque)) (null? (rear-ptr deque))))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT-DEQUE called with an empty deque" deque)
      (value (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR-DEQUE called with an empty deque" deque)
      (value (rear-ptr deque))))

(define (front-insert-deque! deque item)
  (letrec ((new-value-pair (cons '() item))
           (new-node (cons new-value-pair '())))
    (if (empty-deque? deque)
        (begin
         (set-front-ptr! deque new-node)
         (set-rear-ptr! deque new-node))
        (begin
         (set-previous! (front-ptr deque) new-node)
         (set-next! new-node (front-ptr deque))
         (set-front-ptr! deque new-node)))
    (print-deque deque)))
        
(define (rear-insert-deque! deque item)
  (letrec ((new-value-pair (cons '() item))
           (new-node (cons new-value-pair '())))
    (if (empty-deque? deque)
        (begin
         (set-front-ptr! deque new-node)
         (set-rear-ptr! deque new-node))
        (begin
         (set-next! (rear-ptr deque) new-node)
         (set-previous! new-node (rear-ptr deque))
         (set-rear-ptr! deque new-node)))
    (print-deque deque)))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "FRONT-DELETE-DEQUE called with an empty deque" deque))
        ((eq? (front-ptr deque) (rear-ptr deque))
         (set-front-ptr! deque '())
         (set-rear-ptr! deque '()))
        (else 
         (let ((next-node (next (front-ptr deque))))
           (set-front-ptr! deque next-node)
           (if (not (null? next-node))
               (set-previous! (front-ptr deque) '())))))
      (print-deque deque))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "REAR-DELETE-DEQUE called with an empty deque" deque))
        ((eq? (front-ptr deque) (rear-ptr deque))
         (set-front-ptr! deque '())
         (set-rear-ptr! deque '()))
        (else
         (let ((previous-node (previous (rear-ptr deque))))
           (set-rear-ptr! deque previous-node)
           (if (not (null? previous-node))
               (set-next! (rear-ptr deque) '())))))
  (print-deque deque))

(define (print-deque deque)
  (letrec ((print-list-of-deque-nodes 
            (lambda (first-node)
              (display (value first-node))
              (display " ")
              (let ((next-node (next first-node)))
                (if (not (null? next-node))
                    (print-list-of-deque-nodes next-node)
                    (display "]"))))))
    (if (empty-deque? deque)
        (display "Deque is empty !")
        (begin
         (display "Deque : [ ")
         (print-list-of-deque-nodes (front-ptr deque))))))

; Voorbeeld :

>>> (define d (make-deque))
d
>>> (print-deque d)
Deque is empty !
>>> (front-insert-deque! d 1)
Deque : [ 1 ]
>>> (front-insert-deque! d 2)
Deque : [ 2 1 ]
>>> (rear-insert-deque! d 3)
Deque : [ 2 1 3 ]
>>> (front-delete-deque! d)
Deque : [ 1 3 ]
>>> (empty-deque? d)
#f
>>> (print-deque d)
Deque : [ 1 3 ]
>>> (front-deque d)
1
>>> (rear-deque d)
3
>>> (rear-delete-deque! d)
Deque : [ 1 ]
>>> (rear-insert-deque! d 2)
Deque : [ 1 2 ]
>>> (rear-delete-deque! d)
Deque : [ 1 ]
>>> (rear-delete-deque! d)
Deque is empty !

()            
;3.3.3 Representing Tables

(define (lookup key table)
  (let ((record (assq key (cdr table))))
    (if (null? record)
        '()
        (cdr record))))

(define (assq key records)
  (cond ((null? records) '())
        ((eq? key (caar records)) (car records))
        (else (assq key (cdr records)))))

(define (insert! key value table)
  (let ((record (assq key (cdr table))))
    (if (null? record)
        (set-cdr! table
                  (cons (cons key value) (cdr table)))
        (set-cdr! record value)))
  'ok)

(define (make-table)
  (list '*table*))

;;; Two-dimensional tables

(define (lookup key-1 key-2 table)
  (let ((subtable (assq key-1 (cdr table))))
    (if (null? subtable)
        '()
        (let ((record (assq key-2 (cdr subtable))))
          (if (null? record)
              '()
              (cdr record))))))

(define (insert! key-1 key-2 value table)
  (let ((subtable (assq key-1 (cdr table))))
    (if (null? subtable)
        (set-cdr! table
                  (cons (list key-1
                              (cons key-2 value))
                        (cdr table)))
        (let ((record (assq key-2 (cdr subtable))))
          (if (null? record)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))
              (set-cdr! record value)))))
  'ok)

;;; Creating local tables

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assq key-1 (cdr local-table))))
        (if (null? subtable)
            '()
            (let ((record (assq key-2 (cdr subtable))))
              (if (null? record)
                  '()
                  (cdr record))))))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assq key-1 (cdr local-table))))
        (if (null? subtable)
            (set-cdr! local-table
                  (cons (list key-1
                              (cons key-2 value))
                        (cdr local-table)))
            (let ((record (assq key-2 (cdr subtable))))
              (if (null? record)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))
                  (set-cdr! record value)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))

(define get (operation-table 'lookup-proc))

(define put (operation-table 'insert-proc!))


;; EXERCISE 3.24

(define (association same-key?)
  (lambda (key-records)
    (cond ((null? records) '())
          ((same-key? key (caar records)) (car records))
          (else 
           ((association same-key?) key (cdr records))))))

(define (make-table same-key?)
  (let ((local-table (list '*table*))
        (assoc (association same-key?)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if (null? subtable)
            '()
            (let ((record (assoc key-2 (cdr subtable))))
              (if (null? record)
                  '()
                  (cdr record))))))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if (null? subtable)
            (set-cdr! local-table
                  (cons (list key-1
                              (cons key-2 value))
                        (cdr local-table)))
            (let ((record (assoc key-2 (cdr subtable))))
              (if (null? record)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))
                  (set-cdr! record value)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

    
;; EXERCISE 3.25

(define same-key? =?)

(define (association key records)
  (cond ((null? records) '())
        ((same-key? key (caar records)) (car records))
        (else (association key (cdr records)))))

(define (make-table)
  (list '*table*))

(define (make-record key datum)
  (cons key datum))

(define (record? item)
  (if (pair? item)
      (string? (cdr item))
      #f))

(define (lookup list-of-keys table)
  (letrec ((lookup-proc 
            (lambda (first-key rest-of-keys table)
              (let ((subtable (association first-key (cdr table))))
                (if (null? subtable)
                    '()
                    (if (null? rest-of-keys)
                        (let ((possible-record (cdr subtable)))
                          (if (record? possible-record)
                              possible-record
                              (error "There is more than one record matching the specified keys -- LOOKUP")))
                        (lookup-proc (car rest-of-keys)
                                     (cdr rest-of-keys)
                                     subtable)))))))
    (if (null? list-of-keys)
        (error "No keys specified in LOOKUP procedure")
        (lookup-proc (car list-of-keys)
                     (cdr list-of-keys)
                     table))))

(define (insert! list-of-keys value table)
  (letrec ((insert-proc
            (lambda (first-key rest-of-keys table)
              (let ((subtable (association first-key (cdr table))))
                (display "subtable")
                (if (null? subtable)
                    (set-cdr! table
                              (cons (make-subtable first-key
                                                   rest-of-keys
                                                   value)
                                    (cdr table)))
                    (if (null? rest-of-keys)
                        (let ((possible-record (cdr subtable)))
                          (if (record? possible-record)
                              (set-cdr! subtable
                                        (cons (cons first-key value)
                                              (cdr subtable)))
                              (error "There is more than one record matching the specified keys -- LOOKUP")))
                        (insert-proc (car rest-of-keys)
                                     (cdr rest-of-keys)
                                     subtable)))))))
    (if (null? list-of-keys)
        (error "No keys specified in INSERT procedure")
        (insert-proc (car list-of-keys)
                     (cdr list-of-keys)
                     table))))

(define (make-subtable first-key rest-of-keys value)
  (if (null? rest-of-keys)
      (cons first-key value)
      (list first-key 
            (make-subtable (car rest-of-keys)
                           (cdr rest-of-keys)
                           value))))
      

;; EXERCISE 3.27

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
        (if (not (null? previously-computed-result))
            previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

;; 3.3.4 A Simulator for Digital Circuits

(define a (make-wire))
(define b (make-wire))
(define c (make-wire))
(define d (make-wire))
(define e (make-wire))
(define s (make-wire))

(define (half-adder a b s c)
  (let ((d (make-wire)) 
        (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)    
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)))


;;; Primitive function boxes

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! input invert-input))

(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Invalid signal" s))))

(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure))


;; EXERCISE 3.28

(define (logical-and a1 a2)
  (cond ((and (= a1 1) (= a2 1)) 1)
        ((and (or (= a1 1) (= a1 0))
              (or (= a2 1) (= a2 0))) 0)
        (else (error "One of the signals is invalid" a1 a2)))) 
      
(define (logical-or a1 a2)
  (cond ((and (= a1 0) (= a2 0)) 0)
        ((and (or (= a1 1) (= a1 0))
              (or (= a2 1) (= a2 0))) 1)
        (else (error "One of the signals is invalid" a1 a2))))    

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure))


;; EXERCISE 3.29

; maak gebruik van het feit dat 
; (a OR b) = { NOT [ (NOT A) AND (NOT B) ] }

(define (or-gate a1 a2 output)
  (let ((not-a (make-wire))
        (not-b (make-wire))
        (not-a-and-not-b (make-wire)))
    (inverter a not-a)
    (inverter b not-b)
    (and-gate not-a not-b not-a-and-not-b)
    (inverter not-a-and-not-b output)))

; delay time van de or-gate :
;    delay-time van een inverter (wire a of wire b)
;  + delay-time van een and-gate (op wires not-a en not-b)
;  + delay-time van een inverter (wire not-a-and-not-b)
; = 2*delay-time-inverter + delay-time-and-gate


;; EXERCISE 3.30

(define (ripple-carry-adder list-a list-b list-s c)
  (if (not (null list-a))
      (begin
        (full-adder c (car list-a) (car list-b) 
                      (car list-c) (car list-s))
        (ripple-carry-adder (cdr list-a) (cdr list-b) 
                            (cdr list-c) (car list-c)))))

; opm : list-a, list-b en list-c moeten zelfde lengte hebben    
    
; delay-time = n*delay-time-full-adder
;   delay-time-full-adder  (zie figuur 3.25)
;     = 2*delay-time-half-adder + delay-time-or-gate
;   delay-time-half-adder  (zie figuur 3.24)
;     = (max (delay-time-or-gate , (delay-time-and-gate + 
;                                    delay-time-inverter) ) )
;        + delay-time-and-gate


;;; Representing wires

(define (make-wire)
  (let ((signal-value 0)
        (action-procedures '()))
    (define (set-my-signal! new-value)
       ; set-my-signal! verandert de signal-value naar een nieuwe opgegeven
       ; waarde new-value
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-procedures))
          'done))  
    (define (accept-action-procedure proc)
       ; accept-action-procedures plaatst een nieuwe actie op een draad, en
       ; voert die ene aktie ook onmiddellijk uit
      (set! action-procedures (cons proc action-procedures))
      (proc)) 
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure)
            (else (error "Unknown operation -- WIRE" m))))
    dispatch))

(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin
       ((car procedures))
       (call-each (cdr procedures)))))

(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))


;;; The agenda

(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
                  action
                  the-agenda))

(define (propagate)
  (if (empty-agenda? the-agenda)
      'done
      (let ((first-item (first-agenda-item the-agenda)))
        (first-item)
        (remove-first-agenda-item! the-agenda)
        (propagate))))

;;; A sample simulation

(define (probe name wire)
  (add-action! wire
               (lambda ()
                 (display name)
                 (display " ")
                 (display (current-time the-agenda))
                 (display "  New-value = ")
                 (display (get-signal wire))
                 (newline))))

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

(probe 'sum sum)

(probe 'carry carry)

(half-adder input-1 input-2 sum carry)
(set-signal! input-1 1)

(propagate)

(set-signal! input-2 1)

(propagate)


;;; Implementing the agenda

(define (make-time-segment time queue)
  (cons time queue))

(define (segment-time s) (car s))

(define (segment-queue s) (cdr s))

(define (make-agenda)
  (list '*agenda*
        (make-time-segment 0 (make-queue))))

(define (segments agenda) (cdr agenda))

(define (first-segment agenda) (car (segments agenda)))

(define (rest-segments agenda) (cdr (segments agenda)))

(define (set-segments! agenda segments)
  (set-cdr! agenda segments))

(define (current-time agenda)
  (segment-time (first-segment agenda)))

(define (empty-agenda? agenda)
  (and (empty-queue? (segment-queue (first-segment agenda)))
       (null? (rest-segments agenda))))

(define (add-to-agenda! time action agenda)
  (define (add-to-segments! segments)
    (if (= (segment-time (car segments)) time)
        (insert-queue! (segment-queue (car segments))
                       action)
        (let ((rest (cdr segments)))
          (cond ((null? rest)
                 (insert-new-time! time action segments))
                ((> (segment-time (car rest)) time)
                 (insert-new-time! time action segments))
                (else (add-to-segments! rest))))))
  (add-to-segments! (segments agenda)))

(define (insert-new-time! time action segments)
  (let ((q (make-queue)))
    (insert-queue! q action)
    (set-cdr! segments
              (cons (make-time-segment time q)
                    (cdr segments)))))

(define (remove-first-agenda-item! agenda)
  (delete-queue! (segment-queue (first-segment agenda))))

(define (first-agenda-item agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (if (empty-queue? q)
        (begin (set-segments! agenda
                              (rest-segments agenda))
               (first-agenda-item agenda))
        (front q)))) 
                


    
