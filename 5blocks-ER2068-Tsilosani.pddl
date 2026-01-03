(define (problem 5blocks-ER2068-Tsilosani)
  (:domain blocks-world)
  (:objects a b c d e - block)
  (:init
    (handempty)

    (onfloor a)
    (on b a)
    (on c b)
    (clear c)

    (onfloor d)
    (on e d)
    (clear e)
  )

  (:goal
    (and
      (on d b)
      (onfloor b)
      (onfloor a)
      (onfloor c)
      (onfloor e)
    )
  )
)