(define (problem prob_ext1_2)
    (:domain domini_ext1)
    (:objects 
        r01 r02 r03 - rover
        al01 al02 al03 al04 al05 - almacen
        as01 as02 as03 as04 - asentamiento
        p01 p02 p03 - persona
        s01 s02 s03 - suministro
    )

    (:init
        (= (cantidad-personas r01) 0)
        (= (cantidad-suministros r01) 0)

        (= (cantidad-personas r02) 0)
        (= (cantidad-suministros r02) 0)

        (estacionado r01 as01) (estacionado r02 as04) (estacionado r03 as02)

        ;mapa cuadrícula
        (adyacente al01 as01) (adyacente al01 as04)
        (adyacente al02 as01) (adyacente al02 as02)
        (adyacente al03 as02) (adyacente al03 as03)
        (adyacente al04 as04) (adyacente al04 as03)
        (adyacente al05 as01) (adyacente al05 as02)
        (adyacente al05 as03) (adyacente al05 as04)

        (adyacente as01 al01) (adyacente as01 al02)
        (adyacente as02 al02) (adyacente as02 al03)
        (adyacente as03 al03) (adyacente as03 al04)
        (adyacente as04 al01) (adyacente as04 al04)
        (adyacente as01 al05) (adyacente as02 al05)
        (adyacente as03 al05) (adyacente as04 al05)

        (peticion p01 as01) (peticion p02 as01) (peticion p03 as03) (peticion p01 as04)
        (enBase p01 as03) (enBase p02 as03) (enBase p03 as04) 

        (peticion s01 as01) (peticion s02 as02) (peticion s03 as03) (peticion s02 as04)
        (enBase s01 al04) (enBase s02 al03) (enBase s03 al01)
    )

    (:goal (forall (?rec - recursos) (servido ?rec)))

)