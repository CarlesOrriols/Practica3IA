import os
import sys

def main():

    if (len(sys.argv)>1):
        problem_file = sys.argv[1]
    else:
        problem_file = "prob_ext2_v2.pddl"

    if (len(sys.argv)>2):
        domain_file = sys.argv[2]
    else:
        # domain_file = "domini_ext2.pddl"
        domain_file = "domini_punt_extra_1.pddl"

    escriureProblema(domain_file)
    executarProblemaPDDL(domain_file, problem_file)
    # print("executant punt extra 1")


def escriureProblema(domain_file, ):
    f = open(domain_file, "w")
    f.write("Now the file has more content!")
    f.close()


def executarProblemaPDDL(domain_file, problem_file):
    os.system("ff -o " + domain_file + " -f " + problem_file + " -O")

main()
