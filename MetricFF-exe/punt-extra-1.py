import os
import sys
import random

def main():

    if (len(sys.argv)>2):
        problem_file = sys.argv[2]
    else:
        # problem_file = "prob_ext2_v2"
        problem_file = "prob_ext3_punt_extra"


    if (len(sys.argv)>1):
        domain_file = sys.argv[1]
    else:
        domain_file = "domini_ext3"

    # num_rovers=2, num_peticions=9, num_persones=2, num_subministres=3, gasolina_inici=10, num_peticions_persones=4, num_peticions_subministres=4
    escriureProblema(problem_file, domain_file, 2, 9, 2, 3, 10, 4, 4)
    # executarProblemaPDDL(domain_file, problem_file)
    # print("executant punt extra 1")


def escriureProblema(problem_file, domain_file, num_rovers, num_peticions, num_persones, num_subministres, gasolina_inici, num_peticions_persones, num_peticions_subministres):
    bases = [["al1", "al2", "al3", "al4"], ["as1", "as2", "as3", "as4"]]
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
    f.write("\t\t(= (suma-prioridades) 0)\n")
    f.write("\t\t(= (suma-combustible-gastado) 0)\n\n")
    for x in range(1,num_rovers+1):
        f.write("\t\t(= (cantidad-personas r" + str(x) + ") 0)\n")
        f.write("\t\t(= (cantidad-suministros r" + str(x) + ") 0)\n")
        f.write("\t\t(= (combustible-gastado r" + str(x) + ") 0)\n\n")
    printar_inicio_rovers(f, num_rovers, bases)
    printar_grafo_adyacencias_constante(f)
    peticiones_prioridades(f, num_persones, num_subministres, num_peticions_persones, num_peticions_subministres, bases)
    f.write("\t)\n") # Tercer parentesi

    f.write("\t(:goal (forall (?rec - recursos) (servido ?rec)))\n")
    f.write("\t(:metric maximize(suma-prioridades))\n")

    f.write(")") # Primer parentesi
    f.close()

def printar_inicio_rovers(f, num_rovers, bases):
    f.write("\t\t;ESTACIONAMENT DELS ROVERS\n")
    f.write("\t\t")
    for x in range(1, num_rovers+1):
        b = bases[random.randint(0,1)][random.randint(0,3)]
        f.write("(estacionado r" + str(x) + " " + b +") ")
    f.write("\n\n")

# generarlo aleatoriament es complicat -> https://www.i-ciencias.com/pregunta/77453/espera-que-los-pasos-para-obtener-un-grafo-conexo
def printar_grafo_adyacencias_constante(f):
    f.write("\t\t;MATRIU D ADJACENCIES\n")
    f.write("\t\t(adjacente as1 as2) (adjacente as2 as1)\n")
    f.write("\t\t(adjacente al1 al2) (adjacente al2 al1)\n")
    f.write("\t\t(adjacente al2 al3) (adjacente al3 al2)\n")
    f.write("\t\t(adjacente al3 al4) (adjacente al4 al3)\n")
    f.write("\t\t(adjacente as1 al1) (adjacente al1 as1)\n")
    f.write("\t\t(adjacente as2 al2) (adjacente al2 as2)\n")
    f.write("\t\t(adjacente as3 al4) (adjacente al4 as3)\n")
    f.write("\t\t(adjacente as4 al3) (adjacente al3 as4)\n")
    f.write("\t\t(adjacente as1 al4) (adjacente al4 as1)\n")

def peticiones_prioridades(f, num_persones, num_subministres, num_peticions_persones, num_peticions_subministres, bases):
    prioridades = [1,2,3]
    f.write("\n\t\t;PETICIONS DE LES PERSONES I LES SEVES PRIORITATS\n")
    for x in range(1,num_persones+1):
        bOr = bases[1][random.randint(0,3)]
        bDe = bases[1][random.randint(0,3)]
        while bOr == bDe:
            bDe = bases[1][random.randint(0,3)]
        f.write("\t\t(enBase p" + str(x) + " " + bOr + ") (peticion p" + str(x) + " " + bDe + ")")

        f.write("\n")

    f.write("\n\t\t;PETICIONS DELS SUBMINISTRES I LES SEVES PRIORITATS\n")
    for x in range(1,num_subministres+1):
        bOr = bases[0][random.randint(0,3)]
        bDe = bases[1][random.randint(0,3)]
        f.write("\t\t(enBase s" + str(x) + " " + bOr + ") (peticion p" + str(x) + " " + bDe + ")")

        f.write("\n")



def executarProblemaPDDL(domain_file, problem_file):
    os.system("ff -o " + domain_file + ".pddl -f " + problem_file + ".pddl -O")

main()
