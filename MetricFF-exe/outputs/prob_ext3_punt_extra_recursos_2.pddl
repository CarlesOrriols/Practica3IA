; Aixo es un problema PDDL generat automaticament per un script del Pol, Neus, Pau i Carles
(define (problem prob_ext3_punt_extra_recursos_2)
	(:domain domini_ext3)
	(:objects
		r1 r2 - rover
		al1 al2 al3 al4 al5 - almacen
		as1 as2 as3 as4 as5 as6 as7 as8 as9 as10 - asentamiento
		p1 p2 p3 p4 - persona
		s1 s2 s3 s4 - suministro
	)

	(:init
		(= (capacidad-combustible) 50)
		(= (suma-prioridades) 24)
		(= (suma-combustible-no-gastado) 100)

		(= (cantidad-personas r1) 0)
		(= (cantidad-suministros r1) 0)
		(= (combustible-gastado r1) 0)

		(= (cantidad-personas r2) 0)
		(= (cantidad-suministros r2) 0)
		(= (combustible-gastado r2) 0)

		;ESTACIONAMENT DELS ROVERS
		(estacionado r1 al4) (estacionado r2 as8) 

		;MATRIU D ADJACENCIES
		(adyacente as8 as1) (adyacente as1 as8)
		(adyacente al4 al2) (adyacente al2 al4)
		(adyacente as9 as6) (adyacente as6 as9)
		(adyacente al1 as4) (adyacente as4 al1)
		(adyacente al1 as1) (adyacente as1 al1)
		(adyacente as1 as2) (adyacente as2 as1)
		(adyacente as2 al2) (adyacente al2 as2)
		(adyacente al2 as3) (adyacente as3 al2)
		(adyacente as3 as4) (adyacente as4 as3)
		(adyacente as4 al3) (adyacente al3 as4)
		(adyacente al3 as5) (adyacente as5 al3)
		(adyacente as5 as6) (adyacente as6 as5)
		(adyacente as6 al4) (adyacente al4 as6)
		(adyacente al4 as7) (adyacente as7 al4)
		(adyacente as7 as8) (adyacente as8 as7)
		(adyacente as8 al5) (adyacente al5 as8)
		(adyacente al5 as9) (adyacente as9 al5)
		(adyacente as9 as10) (adyacente as10 as9)
		(adyacente as10 al1) (adyacente al1 as10)

		;PETICIONS DE LES PERSONES I LES SEVES PRIORITATS
		(peticion p1 as9) (= (prioridad-peticion p1 as9) 2) (enBase p1 as9)
		(peticion p2 as8) (= (prioridad-peticion p2 as8) 2) (enBase p2 as8)
		(peticion p3 as9) (= (prioridad-peticion p3 as9) 3) (enBase p3 as10)
		(peticion p4 as8) (= (prioridad-peticion p4 as8) 3) (enBase p4 as8)

		;PETICIONS DELS SUBMINISTRES I LES SEVES PRIORITATS
		(peticion s1 as3) (= (prioridad-peticion s1 as3) 3) (enBase s1 al2)
		(peticion s2 as3) (= (prioridad-peticion s2 as3) 2) (enBase s2 al2)
		(peticion s3 as3) (= (prioridad-peticion s3 as3) 3) (enBase s3 al3)
		(peticion s4 as4) (= (prioridad-peticion s4 as4) 2) (enBase s4 al5)
	)

	(:goal (forall (?rec - recursos) (servido ?rec)))
	(:metric maximize(+ (suma-prioridades) (* 2 (suma-combustible-no-gastado))))
)