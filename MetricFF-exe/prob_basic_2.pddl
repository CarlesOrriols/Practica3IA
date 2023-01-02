;Troba solucio perk estan disponibles tots els recursos de les peticions
(define (problem prob_basic_2)
    (:domain domini_basic)
    (:objects 
        r01 r02 - rover
        b01 b02 b03 b04 b05 b06 b07 - base
        rec01 rec02 rec03 rec04 - recursos
    )

    (:init
        (estacionado r01 b03) (estacionado r02 b06)

        (adjacente b01 b02) (adjacente b01 b03) (adjacente b01 b04)
        (adjacente b01 b05) (adjacente b01 b06) (adjacente b01 b07)
        (adjacente b02 b01) (adjacente b02 b03)
        (adjacente b03 b01) (adjacente b03 b02) (adjacente b03 b04)
        (adjacente b04 b01) (adjacente b04 b03)
        (adjacente b05 b01) (adjacente b05 b06)
        (adjacente b06 b01) (adjacente b06 b05) (adjacente b06 b07)
        (adjacente b07 b01) (adjacente b07 b06)

        (peticion rec01 b03) (peticion rec02 b01) (peticion rec03 b05) (peticion rec04 b06) 
        (disponible rec01 b02) (disponible rec02 b04) (disponible rec03 b06) (disponible rec04 b06)
    )

    (:goal (forall (?rec - recursos ?b - base) (imply(peticion ?rec ?b) (servido ?rec))))
)