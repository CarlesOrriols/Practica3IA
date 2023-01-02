(define (domain domini_basic)
    (:requirements :adl :typing)

    (:types rover base recursos - object)

    (:predicates
        (estacionado ?rec - rover ?b - base)
        (disponible ?rec - recursos ?b - base)
        (enRover ?r - rover ?rec - recursos)
        (peticion ?rec - recursos ?b - base)
        (adjacente ?b1 - base ?b2 - base)
        (servido ?rec - recursos)
    )

    (:action cargar_recurso
        :parameters (?r - rover ?b - base ?rec - recursos)
        :precondition (and (disponible ?rec ?b) (estacionado ?r ?b))
        :effect (and (enRover?r ?rec) (not(disponible ?rec ?b)))
    )

    (:action descargar_recurso
        :parameters (?r - rover ?b - base ?rec - recursos)
        :precondition (and (enRover ?r ?rec) (estacionado ?r ?b) (peticion ?rec ?b))
        :effect (and (servido ?rec) (not(enRover ?r ?rec)))
    )
    
    (:action mover_rover
        :parameters (?r - rover ?bOri - base ?bDest - base)
        :precondition (and (estacionado ?r ?bOri) (adjacente ?bOri ?bDest))
        :effect (and (estacionado ?r ?bDest) (not(estacionado ?r ?bOri)))
    ) 
)