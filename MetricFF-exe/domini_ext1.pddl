(define (domain domini_ext1)
    (:requirements :adl :typing :fluents)

    ; EXTENSIO I: Ara podem carregar tambe fins a dos persones al rover.
    ; Si carreguem persones no podrem carregar materials

    (:types rover base recursos - object ; tres classes
            asentamiento almacen - base ; hi ha dos tipus de base (?)
            persona suministro - recursos ; ara els recursos es divideixen en dos: persona i subministrament
    )

    (:predicates
        (estacionado ?r - rover ?b - base) ; el rover esta estacionat a la base b
        (disponible ?rec - recursos ?b - base) ; el recurs en questio esta disponible a la base b
        (enRover ?r - rover ?rec - recursos) ; el recurs aquell es troba al rover
        (peticion ?rec - recursos ?b - base) ; hi ha una peticio de rec recursos a la base
        (adjacente ?b1 - base ?b2 - base) ; b1 i b2 son adjacents
        (servido ?rec - recursos)
    )

    (:functions
        (cantidad-personas ?r - rover) ; et dona la quantitat de gent al rover
        (cantidad-suministros ?r - rover) ; et dona la quantitat de material al rover
    )

    (:action cargar_persona
        :parameters (?r - rover ?as - asentamiento ?p - persona)
        :precondition (and (disponible ?p ?as) (estacionado ?r ?as) (< (cantidad-personas ?r) 2) (= (cantidad-suministros ?r) 0)) ; el recurs en questio (una persona) esta disponible a la base b, no hi ha d'haver materials al rover i la quantitat de persones ha de ser inferior a 2. El rover ha d'estar estacionat a la base.
        :effect (and (enRover ?r ?p) (not(disponible ?p ?as)) (increase (cantidad-personas ?r) 1)) ; incrementa en 1 la quantitat de persones, la persona es situara al rover i no a la base
    )

    (:action cargar_suministro
        :parameters (?r - rover ?al - almacen ?s - suministro)
        :precondition (and  (disponible ?s ?al) (estacionado ?r ?al) (= (cantidad-personas ?r) 0) (= (cantidad-suministros ?r) 0)) ; el recurs en questio (una material) esta disponible a la base b, no hi ha d'haver ni materials ni persones al rover. El rover ha d'estar estacionat a la base.
        :effect (and (enRover ?r ?s) (not(disponible ?s ?al)) (increase (cantidad-suministros ?r) 1)) ; El material ja no esta disbonible a la base i es carrega al rover, incrementa en 1 la qtt de material al rover
    )

    (:action descargar_persona
        :parameters (?r - rover ?as - asentamiento ?p - persona)
        :precondition (and (enRover ?r ?p) (estacionado ?r ?as) (peticion ?p ?as)) ; la persona ha de ser al rover, el rover ha d'estar estacionat a la base i la base ha fet una peticio de la persona
        :effect (and (servido ?p) (not(enRover ?r ?p)) (decrease (cantidad-personas ?r) 1)) ; la persona ja no es al rover i es decrementa la qtt de persones al rover
    )

    (:action descargar_suministro
        :parameters (?r - rover ?al - almacen ?s - suministro)
        :precondition (and (enRover ?r ?s) (estacionado ?r ?al) (peticion ?s ?al)) ; el material ha de ser al rover, el rover ha d'estar estacionat a la base i la base ha fet una peticio del material
        :effect (and (servido ?s) (not(enRover ?r ?s)) (decrease (cantidad-suministros ?r) 1)) ; el material ja no es al rover i es decrementa la qtt de material al rover
    )
    
    (:action mover_rover
        :parameters (?r - rover ?bOri - base ?bDest - base)
        :precondition (and (estacionado ?r ?bOri) (adjacente ?bOri ?bDest)) ; el rover esta estacionat a la baseOri i la baseDest es adjacent
        :effect (and (estacionado ?r ?bDest) (not(estacionado ?r ?bOri))) ; el rover NO esta estacionat a l'origen i ho està a la baseDest
    ) 
)