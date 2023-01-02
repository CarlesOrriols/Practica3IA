(define (domain domini_ext1)
    (:requirements :adl :typing :fluents)

    (:types rover base recursos - object
            asentamiento almacen - base
            persona suministro - recursos
    )

    (:predicates
        (estacionado ?r - rover ?b - base)(disponible ?rec - recursos ?b - base)
        (enRover ?r - rover ?rec - recursos)
        (peticion ?rec - recursos ?b - base)
        (adjacente ?b1 - base ?b2 - base)
        (servido ?rec - recursos)
    )

    (:functions
        (cantidad-personas ?r - rover)
        (cantidad-suministros ?r - rover)
    )

    (:action cargar_persona
        :parameters (?r - rover ?as - asentamiento ?p - persona)
        :precondition (and (disponible ?p ?as) (estacionado ?r ?as) (< (cantidad-personas ?r) 2) (= (cantidad-suministros ?r) 0))
        :effect (and (enRover ?r ?p) (not(disponible ?p ?as)) (increase (cantidad-personas ?r) 1))
    )

    (:action cargar_suministro
        :parameters (?r - rover ?al - almacen ?s - suministro)
        :precondition (and  (disponible ?s ?al) (estacionado ?r ?al) (= (cantidad-personas ?r) 0) (= (cantidad-suministros ?r) 0))
        :effect (and (enRover ?r ?s) (not(disponible ?s ?al)) (increase (cantidad-suministros ?r) 1))
    )

    (:action descargar_persona
        :parameters (?r - rover ?as - asentamiento ?p - persona)
        :precondition (and (enRover ?r ?p) (estacionado ?r ?as) (peticion ?p ?as))
        :effect (and (servido ?p) (not(enRover ?r ?p)) (decrease (cantidad-personas ?r) 1))
    )

    (:action descargar_suministro
        :parameters (?r - rover ?al - almacen ?s - suministro)
        :precondition (and (enRover ?r ?s) (estacionado ?r ?al) (peticion ?s ?al))
        :effect (and (servido ?s) (not(enRover ?r ?s)) (decrease (cantidad-suministros ?r) 1))
    )
    
    (:action mover_rover
        :parameters (?r - rover ?bOri - base ?bDest - base)
        :precondition (and (estacionado ?r ?bOri) (adjacente ?bOri ?bDest))
        :effect (and (estacionado ?r ?bDest) (not(estacionado ?r ?bOri)))
    ) 
)