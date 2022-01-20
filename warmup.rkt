#lang rosette

(define (abs-spec x)
  (if (bvslt x (bv 0 32))
    (bvneg x)
    x
  )
)

(define (abs-impl x)
  (let* ([o1 (bvashr x (bv 31 32))]
        [o2 (bvadd x o1)]
        [o3 (bvsub o2 o1)])
  o3)
)

(assert 
  (equal? 
    (abs-impl (bv #x00000000 32))
    (abs-spec (bv #x00000000 32))
  )
)

(assert (equal? (abs-impl (bv #x00000003 32)) 
                  (abs-spec (bv #x00000003 32))))

(assert (equal? (abs-impl (bv #x80000000 32)) 
                  (abs-spec (bv #x80000000 32))))                  

(define-symbolic x (bitvector 32))
