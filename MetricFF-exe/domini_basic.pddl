(define (domain domini_basic)
    (:requirements :adl :typing)

    (:types rover base recursos - object
            asentamiento almacen - base
            persona suministro - recursos
    )

    (:predicates
        (estacionado ?r - rover ?b - base); el rover esta estacionat a la base b
        (enBase ?rec - recursos ?b - base); el recurs en questio esta disponible a la base b
        (enRover ?r - rover ?rec - recursos); el recurs aquell es troba al rover
        (peticion ?rec - recursos ?as - asentamiento); hi ha una peticio de rec recursos a la base
        (adyacente ?b1 - base ?b2 - base); b1 i b2 son adjacents
        (servido ?rec - recursos)
    )

    (:action cargar_persona
        :parameters (?r - rover ?as - asentamiento ?p - persona)
        :precondition (and (not(servido ?p)) (enBase ?p ?as) (estacionado ?r ?as))
        :effect (and (enRover ?r ?p) (not(enBase ?p ?as)))
    )

    (:action cargar_suministro
        :parameters (?r - rover ?al - almacen ?s - suministro)
        :precondition (and (not(servido ?s)) (enBase ?s ?al) (estacionado ?r ?al))
        :effect (and (enRover ?r ?s) (not(enBase ?s ?al)))
    )

    (:action descargar_persona
        :parameters (?r - rover ?as - asentamiento ?p - persona)
        :precondition (and (enRover ?r ?p) (estacionado ?r ?as) (peticion ?p ?as) )
        :effect (and (servido ?p) (not (peticion ?p ?as)) (enBase ?p ?as) (not(enRover ?r ?p)))
    )

    (:action descargar_suministro
        :parameters (?r - rover ?as - asentamiento ?s - suministro)
        :precondition (and (enRover ?r ?s) (estacionado ?r ?as) (peticion ?s ?as))
        :effect (and (servido ?s) (not (peticion ?s ?as)) (enBase ?s ?as) (not(enRover ?r ?s)))
    )
    
    (:action mover_rover
        :parameters (?r - rover ?bOri - base ?bDest - base)
        :precondition (and (estacionado ?r ?bOri) (adyacente ?bOri ?bDest)) ; el rover esta estacionat a la baseOri i la baseDest es adjacent
        :effect (and (estacionado ?r ?bDest) (not(estacionado ?r ?bOri))) ; el rover NO esta estacionat a l'origen i ho està a la baseDest
    )

    (:action se_queda	; (recurs) es necessita a la base i... es queda!
	  :parameters (?rec - recursos ?as - asentamiento)
	  :precondition (and
			(enBase ?rec ?as)
			(peticion ?rec ?as)
		)
	  :effect (and
			(not (peticion ?rec ?as))
			(servido ?rec)
		)
	) 
)