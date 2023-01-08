import os
import sys
import random
import time

def main():
    if (len(sys.argv)>2):
        problem_file = sys.argv[2]
    else:
        problem_file = "prob_ext3_punt_extra"


    if (len(sys.argv)>1):
        domain_file = sys.argv[1]
    else:
        domain_file = "domini_ext3"

    maxim_seg_iteracio = 150
    que_incrementa = "rovers"
    # maxim_seg_iteracio = 4, que_incrementa = "rovers/peticions/recursos"
    problemes_incrementals(maxim_seg_iteracio, que_incrementa, problem_file, domain_file)

def problemes_incrementals(maxim_seg_iteracio, que_incrementa, problem_file, domain_file):
    num_rovers=2
    num_persones=2
    num_subministres=2
    gasolina_inici=50
    num_peticions_persones=4
    num_peticions_subministres=4

    temps_sobrepassat = False
    # text_resum = "\n\nAnalitzant que passa amb incrementar " + que_incrementa + "\n"
    print("\n\nAnalitzant que passa amb incrementar " + que_incrementa + "\n")
    limit_iteracions = 10
    ites = 0
    while not temps_sobrepassat:
        escriureProblema(problem_file, domain_file, num_rovers, num_persones, num_subministres, gasolina_inici, num_peticions_persones, num_peticions_subministres)

        start = time.time()
        os.system("timeout " + str(maxim_seg_iteracio) + "s ff -o " + domain_file + ".pddl -f " + problem_file + ".pddl -O > outputs/respostes-" + que_incrementa + "-" + str(ites) + ".txt" )
        end = time.time()
        temps_total = end - start

        if que_incrementa == "rovers":
            # text_resum += "\tPer " + str(num_rovers) + " rovers ha tardat " + str(temps_total) + "segons.\n"
            print("\tPer " + str(num_rovers) + " rovers ha tardat " + str(temps_total) + " segons.\n")
            num_rovers += 1
        elif que_incrementa == "peticions":
            # text_resum += "\tPer " + str(num_peticions_persones) + " peticions de persones i " + str(num_peticions_subministres) + " peticions de subministres ha tardat " + str(temps_total) + "segons.\n"
            print("\tPer " + str(num_peticions_persones) + " peticions de persones i " + str(num_peticions_subministres) + " peticions de subministres ha tardat " + str(temps_total) + " segons.\n")
            num_peticions_persones += 1
            num_peticions_subministres += 1
        elif que_incrementa == "recursos":
            # text_resum += "\tPer " + str(num_persones) + " persones i " + str(num_subministres) + " subministres ha tardat " + str(temps_total) + "segons.\n"
            print("\tPer " + str(num_persones) + " persones i " + str(num_subministres) + " subministres ha tardat " + str(temps_total) + " segons.\n")
            num_persones += 1
            num_subministres += 1

        ites += 1
        if (limit_iteracions < ites) or temps_total >= maxim_seg_iteracio:
            temps_sobrepassat = True
    # print(text_resum)


def escriureProblema(problem_file, domain_file, num_rovers, num_persones, num_subministres, gasolina_inici, num_peticions_persones, num_peticions_subministres):
    bases = [["al1", "al2", "al3", "al4", "al5"], ["as1", "as2", "as3", "as4", "as5", "as6", "as7", "as8", "as9", "as10"]]
    f = open(problem_file + ".pddl", "w")
    f.write("; Aixo es un problema PDDL generat automaticament per un script del Pol, Neus, Pau i Carles\n")
    f.write("(define (problem " + problem_file + ")\n") # Primer parentesi

    f.write("\t(:domain " + domain_file + ")\n")

    f.write("\t(:objects\n") # Segon parentesi
    f.write("\t\t")
    for x in range(1,num_rovers+1): # Generant rovers
        f.write("r" + str(x) + " ")
    f.write("- rover\n")
    f.write("\t\t")
    for x in bases[0]: # Generant almacenes
        f.write(x + " ")
    f.write("- almacen\n")
    f.write("\t\t")
    for x in bases[1]: # Generant asentamientos
        f.write(x + " ")
    f.write("- asentamiento\n")
    f.write("\t\t")
    for x in range(1,num_persones+1): # Generant persones
        f.write("p" + str(x) + " ")
    f.write("- persona\n")
    f.write("\t\t")
    for x in range(1,num_subministres+1): # Generant suministros
        f.write("s" + str(x) + " ")
    f.write("- suministro\n")
    f.write("\t)\n\n") # Segon parentesi

    f.write("\t(:init\n") # Tercer parentesi
    f.write("\t\t(= (capacidad-combustible) " + str(gasolina_inici) + ")\n")
    f.write("\t\t(= (suma-prioridades) " + str((num_persones+num_subministres)*3) + ")\n")
    f.write("\t\t(= (suma-combustible-no-gastado) " + str(num_rovers*gasolina_inici) + ")\n\n")
    for x in range(1,num_rovers+1):
        f.write("\t\t(= (cantidad-personas r" + str(x) + ") 0)\n")
        f.write("\t\t(= (cantidad-suministros r" + str(x) + ") 0)\n")
        f.write("\t\t(= (combustible-gastado r" + str(x) + ") 0)\n\n")
    printar_inicio_rovers(f, num_rovers, bases)
    printar_grafo_adyacencias_constante(f)
    peticiones_prioridades(f, num_persones, num_subministres, num_peticions_persones, num_peticions_subministres, bases)
    f.write("\t)\n\n") # Tercer parentesi

    f.write("\t(:goal (forall (?rec - recursos) (servido ?rec)))\n")
    f.write("\t(:metric maximize(+ (suma-prioridades) (* 2 (suma-combustible-no-gastado))))\n")

    f.write(")") # Primer parentesi
    f.close()

def printar_inicio_rovers(f, num_rovers, bases):
    f.write("\t\t;ESTACIONAMENT DELS ROVERS\n")
    f.write("\t\t")
    for x in range(1, num_rovers+1):
        t_b = random.randint(0,1)
        n_b = random.randint(0,len(bases[t_b])-1)
        b = bases[t_b][n_b]
        f.write("(estacionado r" + str(x) + " " + b +") ")
    f.write("\n\n")

def printar_grafo_adyacencias_constante(f):
    f.write("\t\t;MATRIU D ADJACENCIES\n")
    f.write("\t\t(adyacente as8 as1) (adyacente as1 as8)\n")
    f.write("\t\t(adyacente al4 al2) (adyacente al2 al4)\n")
    f.write("\t\t(adyacente as9 as6) (adyacente as6 as9)\n")
    f.write("\t\t(adyacente al1 as4) (adyacente as4 al1)\n")

    f.write("\t\t(adyacente al1 as1) (adyacente as1 al1)\n")
    f.write("\t\t(adyacente as1 as2) (adyacente as2 as1)\n")
    f.write("\t\t(adyacente as2 al2) (adyacente al2 as2)\n")
    f.write("\t\t(adyacente al2 as3) (adyacente as3 al2)\n")
    f.write("\t\t(adyacente as3 as4) (adyacente as4 as3)\n")
    f.write("\t\t(adyacente as4 al3) (adyacente al3 as4)\n")
    f.write("\t\t(adyacente al3 as5) (adyacente as5 al3)\n")
    f.write("\t\t(adyacente as5 as6) (adyacente as6 as5)\n")
    f.write("\t\t(adyacente as6 al4) (adyacente al4 as6)\n")
    f.write("\t\t(adyacente al4 as7) (adyacente as7 al4)\n")
    f.write("\t\t(adyacente as7 as8) (adyacente as8 as7)\n")
    f.write("\t\t(adyacente as8 al5) (adyacente al5 as8)\n")
    f.write("\t\t(adyacente al5 as9) (adyacente as9 al5)\n")
    f.write("\t\t(adyacente as9 as10) (adyacente as10 as9)\n")
    f.write("\t\t(adyacente as10 al1) (adyacente al1 as10)\n")


def peticiones_prioridades(f, num_persones, num_subministres, num_peticions_persones, num_peticions_subministres, bases):
    prioridades = [1,2,3]
    f.write("\n\t\t;PETICIONS DE LES PERSONES I LES SEVES PRIORITATS\n")
    peticions_pers = {}
    for x in range(1,num_persones+1):
        bOr = bases[1][random.randint(0,len(bases[1])-1)]
        peticions_pers["p" + str(x)] = []

        bDe = bases[1][random.randint(0,len(bases[1])-1)]
        while bDe in peticions_pers["p" + str(x)]:
            bDe = bases[1][random.randint(0,3)]
        peticions_pers["p" + str(x)].append(bDe)
        pri = random.randint(0,2)

        f.write("\t\t(peticion p" + str(x) + " " + bDe + ") (= (prioridad-peticion p" + str(x) + " " + bDe + ") " + str(prioridades[pri]) + ") (enBase p" + str(x) + " " + bOr + ")\n")

    for l in range(num_persones+1, num_peticions_persones+1):
        x = random.randint(1,num_persones)
        bDe = bases[1][random.randint(0,len(bases[1])-1)]
        while bDe in peticions_pers["p" + str(x)]:
            x = random.randint(1,num_persones)
            bDe = bases[1][random.randint(0,len(bases[1])-1)]
        peticions_pers["p" + str(x)].append(bDe)
        pri = random.randint(0,2)

        f.write("\t\t(peticion p" + str(x) + " " + bDe + ") (= (prioridad-peticion p" + str(x) + " " + bDe + ") " + str(prioridades[pri]) + ")\n")


    f.write("\n\t\t;PETICIONS DELS SUBMINISTRES I LES SEVES PRIORITATS\n")
    peticions_subs = {}
    for x in range(1,num_subministres+1):
        bOr = bases[0][random.randint(0,len(bases[0])-1)]
        peticions_subs["s" + str(x)] = []

        bDe = bases[1][random.randint(0,3)]
        while bDe in peticions_subs["s" + str(x)]:
            bDe = bases[1][random.randint(0,len(bases[1])-1)]
        peticions_subs["s" + str(x)].append(bDe)
        pri = random.randint(0,2)

        f.write("\t\t(peticion s" + str(x) + " " + bDe + ") (= (prioridad-peticion s" + str(x) + " " + bDe + ") " + str(prioridades[pri]) + ") (enBase s" + str(x) + " " + bOr + ")\n")

    for l in range(num_subministres+1, num_peticions_subministres+1):
        x = random.randint(1,num_subministres)
        bDe = bases[1][random.randint(0,len(bases[1])-1)]
        while bDe in peticions_subs["s" + str(x)]:
            x = random.randint(1,num_subministres)
            bDe = bases[1][random.randint(0,len(bases[1])-1)]
        peticions_subs["s" + str(x)].append(bDe)
        pri = random.randint(0,2)

        f.write("\t\t(peticion s" + str(x) + " " + bDe + ") (= (prioridad-peticion s" + str(x) + " " + bDe + ") " + str(prioridades[pri]) + ")\n")


main()
