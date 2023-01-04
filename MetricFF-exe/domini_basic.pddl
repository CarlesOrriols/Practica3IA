(define (domain domini_basic)
    (:requirements :adl :typing)

    (:types rover base recursos - object)

    (:predicates
        (estacionado ?r - rover ?b - base); el rover esta estacionat a la base b
        (disponible ?rec - recursos ?b - base); el recurs en questio esta disponible a la base b
        (enRover ?r - rover ?rec - recursos); el recurs aquell es troba al rover
        (peticion ?rec - recursos ?b - base); hi ha una peticio de rec recursos a la base
        (adjacente ?b1 - base ?b2 - base); b1 i b2 son adjacents
        (servido ?rec - recursos)
    )

    (:action cargar_recurso
        :parameters (?r - rover ?b - base ?rec - recursos)
        :precondition (and (disponible ?rec ?b) (estacionado ?r ?b)) ; la base no te el recurs demanat disponible i el rover esta estacionat a la base
        :effect (and (enRover ?r ?rec) (not(disponible ?rec ?b))) ; el recurs es passara al rover i la base no tindra el recurs agafat disponible
    )

    (:action descargar_recurso
        :parameters (?r - rover ?b - base ?rec - recursos)
        :precondition (and (enRover ?r ?rec) (estacionado ?r ?b) (peticion ?rec ?b)) ; el rover té el recurs rec i esta estacionat a la base b, que te una peticio d'aquell recurs
        :effect (and (servido ?rec) (not(enRover ?r ?rec))) ; el recurs ja no es al rover i es serveix a la base
    )
    
    (:action mover_rover
        :parameters (?r - rover ?bOri - base ?bDest - base)
        :precondition (and (estacionado ?r ?bOri) (adjacente ?bOri ?bDest)) ; el rover esta estacionat a la baseOri i la baseDest es adjacent
        :effect (and (estacionado ?r ?bDest) (not(estacionado ?r ?bOri))) ; el rover NO esta estacionat a l'origen i ho està a la baseDest
    ) 
)