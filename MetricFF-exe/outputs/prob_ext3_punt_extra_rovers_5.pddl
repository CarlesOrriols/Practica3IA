; Aixo es un problema PDDL generat automaticament per un script del Pol, Neus, Pau i Carles
(define (problem prob_ext3_punt_extra_rovers_5)
	(:domain domini_ext3)
	(:objects
		r1 r2 r3 r4 r5 r6 r7 - rover
		al1 al2 al3 al4 al5 - almacen
		as1 as2 as3 as4 as5 as6 as7 as8 as9 as10 - asentamiento
		p1 p2 - persona
		s1 s2 - suministro
	)

	(:init
		(= (capacidad-combustible) 50)
		(= (suma-prioridades) 12)
		(= (suma-combustible-no-gastado) 350)

		(= (cantidad-personas r1) 0)
		(= (cantidad-suministros r1) 0)
		(= (combustible-gastado r1) 0)

		(= (cantidad-personas r2) 0)
		(= (cantidad-suministros r2) 0)
		(= (combustible-gastado r2) 0)

		(= (cantidad-personas r3) 0)
		(= (cantidad-suministros r3) 0)
		(= (combustible-gastado r3) 0)

		(= (cantidad-personas r4) 0)
		(= (cantidad-suministros r4) 0)
		(= (combustible-gastado r4) 0)

		(= (cantidad-personas r5) 0)
		(= (cantidad-suministros r5) 0)
		(= (combustible-gastado r5) 0)

		(= (cantidad-personas r6) 0)
		(= (cantidad-suministros r6) 0)
		(= (combustible-gastado r6) 0)

		(= (cantidad-personas r7) 0)
		(= (cantidad-suministros r7) 0)
		(= (combustible-gastado r7) 0)

		;ESTACIONAMENT DELS ROVERS
		(estacionado r1 al3) (estacionado r2 al3) (estacionado r3 al5) (estacionado r4 as1) (estacionado r5 al1) (estacionado r6 as3) (estacionado r7 al2) 

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
		(peticion p1 as9) (= (prioridad-peticion p1 as9) 3) (enBase p1 as8)
		(peticion p2 as9) (= (prioridad-peticion p2 as9) 1) (enBase p2 as7)
		(peticion p2 as4) (= (prioridad-peticion p2 as4) 3)
		(peticion p1 as7) (= (prioridad-peticion p1 as7) 3)

		;PETICIONS DELS SUBMINISTRES I LES SEVES PRIORITATS
		(peticion s1 as3) (= (prioridad-peticion s1 as3) 3) (enBase s1 al5)
		(peticion s2 as1) (= (prioridad-peticion s2 as1) 3) (enBase s2 al4)
		(peticion s2 as3) (= (prioridad-peticion s2 as3) 1)
		(peticion s1 as5) (= (prioridad-peticion s1 as5) 1)
	)

	(:goal (forall (?rec - recursos) (servido ?rec)))
	(:metric maximize(+ (suma-prioridades) (* 2 (suma-combustible-no-gastado))))
)