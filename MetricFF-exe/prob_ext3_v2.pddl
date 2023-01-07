;tiene en cuenta el combustible
(define (problem prob_ext3_v2)
    (:domain domini_ext3)
        (:objects 
        r01 r02 - rover
        al01 al02 al03 al04 - almacen
        as01 as02 as03 as04 - asentamiento
        p01 p02 p03 - persona
        s01 s02 s03 - suministro
    )

    (:init

        (= (capacidad-combustible) 15)
        (= (suma-prioridades) 0)
        (= (suma-combustible-no-gastado) (* 2 (capacidad-combustible)))

        (= (cantidad-personas r01) 0)
        (= (cantidad-suministros r01) 0)
        (= (combustible-gastado r01) 0)

        (= (cantidad-personas r02) 0)
        (= (cantidad-suministros r02) 0)
        (= (combustible-gastado r02) 0)

        (estacionado r01 as01) (estacionado r02 as04)

        ;mapa cuadrado
        (adjacente al01 as01) (adjacente al01 as04)
        (adjacente al02 as01) (adjacente al02 as02)
        (adjacente al03 as02) (adjacente al03 as03)
        (adjacente al04 as04) (adjacente al04 as03)

        (adjacente as01 al01) (adjacente as01 al02)
        (adjacente as02 al02) (adjacente as02 al03)
        (adjacente as03 al03) (adjacente as03 al04)
        (adjacente as04 al01) (adjacente as04 al04)

        (peticion p01 as01) (peticion p02 as01) (peticion p03 as03) (peticion p01 as04)
        (enBase p01 as03) (enBase p02 as03) (enBase p03 as04) 

        (= (prioridad-peticion p01 as01) 3)
        (= (prioridad-peticion p02 as01) 2)
        (= (prioridad-peticion p03 as03) 2)
        (= (prioridad-peticion p01 as04) 1)

        (peticion s01 al01) (peticion s02 al02) (peticion s03 al03) (peticion s02 al04)
        (enBase s01 al04) (enBase s02 al03) (enBase s03 al01)
        (= (prioridad-peticion s01 al01) 3)
        (= (prioridad-peticion s02 al02) 2)
        (= (prioridad-peticion s03 al03) 2)
        (= (prioridad-peticion s02 al04) 1)
    )

    (:goal (forall (?rec - recursos) (servido ?rec)))

    ;TODO: Combinar max suma de prioritats amb min combustible gastat
    (:metric maximize(+ (suma-prioridades) (suma-combustible-no-gastado)))
)