(define (domain domini_ext3)
    (:requirements :adl :typing :fluents)

    (:types rover base recursos - object
            asentamiento almacen - base
            persona suministro - recursos
    )

    (:predicates
        (estacionado ?r - rover ?b - base)
        (enBase ?rec - recursos ?b - base)
        (enRover ?r - rover ?rec - recursos)
        (peticion ?rec - recursos ?as - asentamiento)
        (adjacente ?b1 - base ?b2 - base)
        (servido ?rec - recursos)
    )

    (:functions
        (cantidad-personas ?r - rover)
        (cantidad-suministros ?r - rover)
        (combustible-gastado ?r - rover)
        (prioridad-peticion ?r - recursos ?b - base)
        (capacidad-combustible)
        (suma-prioridades)
        (suma-combustible-no-gastado)

    )

    (:action cargar_persona
        :parameters (?r - rover ?as - asentamiento ?p - persona)
        :precondition (and (enBase ?p ?as) (estacionado ?r ?as) (not(servido ?p)) (< (cantidad-personas ?r) 2) (= (cantidad-suministros ?r) 0))
        :effect (and (enRover ?r ?p) (not(enBase ?p ?as)) (increase (cantidad-personas ?r) 1))
    )

    (:action cargar_suministro
        :parameters (?r - rover ?al - almacen ?s - suministro)
        :precondition (and  (enBase ?s ?al) (estacionado ?r ?al) (not(servido ?s)) (= (cantidad-personas ?r) 0) (= (cantidad-suministros ?r) 0))
        :effect (and (enRover ?r ?s) (not(enBase ?s ?al)) (increase (cantidad-suministros ?r) 1))
    )

    (:action descargar_persona
        :parameters (?r - rover ?as - asentamiento ?p - persona)
        :precondition (and (enRover ?r ?p) (estacionado ?r ?as) (peticion ?p ?as))
        :effect (and (servido ?p)
                (enBase ?p ?as) (not(enRover ?r ?p)) (decrease (cantidad-personas ?r) 1)
                (decrease (suma-prioridades) (- 3 (prioridad-peticion ?s ?as)))
                )
    )

    (:action descargar_suministro
        :parameters (?r - rover ?as - asentamiento ?s - suministro)
        :precondition (and (enRover ?r ?s) (estacionado ?r ?as) (peticion ?s ?as))
        :effect (and (servido ?s)
                (enBase ?s ?as) (not(enRover ?r ?s)) (decrease (cantidad-suministros ?r) 1)
                (decrease (suma-prioridades) (- 3 (prioridad-peticion ?s ?as)))
        )
    )

    (:action mover_rover
        :parameters (?r - rover ?bOri - base ?bDest - base)
        :precondition (and (estacionado ?r ?bOri) (adjacente ?bOri ?bDest) (> (- (capacidad-combustible) (combustible-gastado ?r)) 0))
        :effect (and (estacionado ?r ?bDest) (not(estacionado ?r ?bOri))
                (increase (combustible-gastado ?r) 1) (decrease (suma-combustible-no-gastado) 1))
    )
)
