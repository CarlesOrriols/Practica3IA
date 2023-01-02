;tiene en cuenta el combustible y encuentra sol
;en doc comparar con prob_ext2 ya que con mismo escenario aqui se realiza en menos pasos
;TODO: estaria be afegir un joc de proves on dos problemes amb mateix escenari i un minimitzant combustible
;un trobes solucio i l'altre no perk no li arribava al combustible al no minimitzarlo
(define (problem prob_ext2_v2)
    (:domain domini_ext2)
    (:objects 
        r01 r02 - rover
        al01 al02 - almacen
        as01 as02 as03 - asentamiento
        p01 p02 p03 - persona
        s01 s02 - suministro
    )

    (:init

        (= (capacidad-combustible) 15)

        (= (cantidad-personas r01) 0)
        (= (cantidad-suministros r01) 0)
        (= (combustible-gastado r01) 0)

        (= (cantidad-personas r02) 0)
        (= (cantidad-suministros r02) 0)
        (= (combustible-gastado r02) 0)

        (estacionado r01 as02) (estacionado r01 al01)

        ;linia recta mapa
        (adjacente as01 as02)
        (adjacente as02 as01) (adjacente as02 al01)
        (adjacente al01 as02) (adjacente al01 al02)
        (adjacente al02 al01) (adjacente al02 as03)
        (adjacente as03 al02)

        (peticion p01 as01) (peticion p02 as03)
        (disponible p01 as01) (disponible p02 as01)
   
        (peticion s01 al01) 
        (disponible s01 al02)
    )

    (:goal (forall (?rec - recursos ?b - base) (imply(peticion ?rec ?b) (servido ?rec))))

    (:metric minimize(+
                (combustible-gastado r01)
                (combustible-gastado r02)
            )
    )
)