;Troba solucio perk estan disponibles tots els recursos de les peticions
(define (problem prob_ext1_2)
    (:domain domini_ext1)
    (:objects 
        r01 r02 r03 - rover
        al01 al02 al03 al04 - almacen
        as01 as02 as03 as04 - asentamiento
        p01 p02 p03 p04 - persona
        s01 s02 s03 s04 - suministro
    )

    (:init
        (= (cantidad-personas r01) 0)
        (= (cantidad-suministros r01) 0)

        (= (cantidad-personas r02) 0)
        (= (cantidad-suministros r02) 0)

        (estacionado r01 as01) (estacionado r02 as04) (estacionado r03 as02)

        ;mapa cuadrado
        (adjacente al01 as01) (adjacente al01 as04)
        (adjacente al02 as01) (adjacente al02 as02)
        (adjacente al03 as02) (adjacente al03 as03)
        (adjacente al04 as04) (adjacente al04 as03)

        (adjacente as01 al01) (adjacente as01 al02)
        (adjacente as02 al02) (adjacente as02 al03)
        (adjacente as03 al03) (adjacente as03 al04)
        (adjacente as04 al01) (adjacente as04 al04)

        (peticion p01 as01) (peticion p02 as01) (peticion p03 as03) (peticion p04 as04)
        (disponible p01 as03) (disponible p02 as03) (disponible p03 as04) (disponible p04 as02) 

        (peticion s01 al01) (peticion s02 al02) (peticion s03 al03) (peticion s04 al04)
        (disponible s01 al04) (disponible s02 al03) (disponible s03 al01) (disponible s04 al02)
    )

    (:goal (forall (?rec - recursos ?b - base) (imply(peticion ?rec ?b) (servido ?rec))))

)