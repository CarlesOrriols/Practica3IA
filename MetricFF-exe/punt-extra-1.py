import os
import sys

def main():

    if (len(sys.argv)>2):
        problem_file = sys.argv[2]
    else:
        # problem_file = "prob_ext2_v2.pddl"
        problem_file = "prob_punt_extra_1.pddl"


    if (len(sys.argv)>1):
        domain_file = sys.argv[1]
    else:
        domain_file = "domini_ext2.pddl"

    # escriureProblema(problem_file)
    executarProblemaPDDL(domain_file, problem_file)
    # print("executant punt extra 1")


def escriureProblema(problem_file):
    f = open(problem_file, "w")
    f.write("Now the file has more content!")
    f.close()


def executarProblemaPDDL(domain_file, problem_file):
    os.system("ff -o " + domain_file + " -f " + problem_file + " -O")

main()
