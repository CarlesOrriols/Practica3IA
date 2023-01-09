; Aixo es un problema PDDL generat automaticament per un script del Pol, Neus, Pau i Carles
(define (problem prob_ext3_punt_extra_recursos_7)
	(:domain domini_ext3)
	(:objects
		r1 r2 - rover
		al1 al2 al3 al4 al5 - almacen
		as1 as2 as3 as4 as5 as6 as7 as8 as9 as10 - asentamiento
		p1 p2 p3 p4 p5 p6 p7 p8 p9 - persona
		s1 s2 s3 s4 s5 s6 s7 s8 s9 - suministro
	)

	(:init
		(= (capacidad-combustible) 50)
		(= (suma-prioridades) 54)
		(= (suma-combustible-no-gastado) 100)

		(= (cantidad-personas r1) 0)
		(= (cantidad-suministros r1) 0)
		(= (combustible-gastado r1) 0)

		(= (cantidad-personas r2) 0)
		(= (cantidad-suministros r2) 0)
		(= (combustible-gastado r2) 0)

		;ESTACIONAMENT DELS ROVERS
		(estacionado r1 as8) (estacionado r2 as4) 

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
		(peticion p1 as10) (= (prioridad-peticion p1 as10) 1) (enBase p1 as10)
		(peticion p2 as5) (= (prioridad-peticion p2 as5) 1) (enBase p2 as1)
		(peticion p3 as5) (= (prioridad-peticion p3 as5) 3) (enBase p3 as6)
		(peticion p4 as4) (= (prioridad-peticion p4 as4) 2) (enBase p4 as2)
		(peticion p5 as2) (= (prioridad-peticion p5 as2) 3) (enBase p5 as4)
		(peticion p6 as7) (= (prioridad-peticion p6 as7) 3) (enBase p6 as6)
		(peticion p7 as3) (= (prioridad-peticion p7 as3) 2) (enBase p7 as8)
		(peticion p8 as2) (= (prioridad-peticion p8 as2) 2) (enBase p8 as7)
		(peticion p9 as2) (= (prioridad-peticion p9 as2) 1) (enBase p9 as2)

		;PETICIONS DELS SUBMINISTRES I LES SEVES PRIORITATS
		(peticion s1 as3) (= (prioridad-peticion s1 as3) 3) (enBase s1 al5)
		(peticion s2 as2) (= (prioridad-peticion s2 as2) 3) (enBase s2 al4)
		(peticion s3 as1) (= (prioridad-peticion s3 as1) 3) (enBase s3 al1)
		(peticion s4 as1) (= (prioridad-peticion s4 as1) 3) (enBase s4 al4)
		(peticion s5 as3) (= (prioridad-peticion s5 as3) 2) (enBase s5 al4)
		(peticion s6 as2) (= (prioridad-peticion s6 as2) 2) (enBase s6 al4)
		(peticion s7 as4) (= (prioridad-peticion s7 as4) 3) (enBase s7 al3)
		(peticion s8 as4) (= (prioridad-peticion s8 as4) 2) (enBase s8 al4)
		(peticion s9 as4) (= (prioridad-peticion s9 as4) 1) (enBase s9 al3)
	)

	(:goal (forall (?rec - recursos) (servido ?rec)))
	(:metric maximize(+ (suma-prioridades) (* 2 (suma-combustible-no-gastado))))
)