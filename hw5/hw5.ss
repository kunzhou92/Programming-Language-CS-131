(define (null-ld? obj) 
	(let ((l (car obj)) (tail (cdr obj))) 
		(eq? l tail)))

			
(define (listdiff? obj) 
	(if (not (pair? obj)) #f
		(let helper ((x (car obj)) (y (cdr obj)))
			(if (eq? x y) #t
				(if (not (pair? x)) #f
					(if (empty? x) #f
						(helper (cdr x) y)))))))
				
(define (cons-ld obj listdiff)
	(if (not (listdiff? listdiff)) 'error
		(let ((l (car listdiff)) (tail (cdr listdiff)))
			(cons (cons obj l) tail))))


(define (car-ld listdiff)
	(if (not (listdiff? listdiff)) 'error
		(if (null-ld? listdiff) 'error
			(car (car listdiff)))))


(define (cdr-ld listdiff) 
	(if (not (listdiff? listdiff)) 'error
		(if (null-ld? listdiff) 'error
			(let ((l (car listdiff)) (tail (cdr listdiff)))
				(cons (cdr l) tail)))))

(define (listdiff obj . args)
	(cons (cons obj args) empty))

(define (length-ld listdiff)
	(if (not (listdiff? listdiff)) 'error
		(if (null-ld? listdiff) 0
			(+ 1 (length-ld (cdr-ld listdiff))))))


(define (app2-ld listdiff1 listdiff2)
	(if (null-ld? listdiff1) listdiff2
		(let ((l (car-ld listdiff1)) (tail (cdr-ld listdiff1)))
			(cons-ld l (app2-ld tail listdiff2)))))

(define (append-ld listdiff . args)
	(if (not (listdiff? listdiff)) 'error
		(let appall ((l listdiff) (tail args))
			(if (empty? tail) l
				(appall (app2-ld l (car tail)) (cdr tail))))))
		

(define (assq-ld obj alistdiff)
	(if (null-ld? alistdiff) #f
		(let ((head (car-ld alistdiff)))
			(if (eq? obj (car head)) head
				(assq-ld obj (cdr-ld alistdiff))))))
		
(define (list->listdiff _list)
	(cons _list empty))
		
(define (listdiff->list listdiff)
	(if (not (listdiff? listdiff)) 'error
		(if (null-ld? listdiff) empty
			(cons (car-ld listdiff)  (listdiff->list (cdr-ld listdiff))))))


(define (expr-returning listdiff) 
	`(list ',(listdiff->list listdiff)))
