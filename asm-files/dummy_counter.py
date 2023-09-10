# This is in no way good
# in fact, this is very bad
# we don't know if any of these numbers mean anything since they don't trace
# execution at all so loops may occur more than 1 time
# or some code portions will not be reached
# this is just to see what we're really dealing with

import sys, getopt

def main(argv):
    num_push = 0
    num_pop = 0
    num_stores = 0
    num_loads = 0
    num_sp_arg = 0

    routines = []

    f = open(argv[1], "r")
    for line in f:
        if "str" in line:
            num_stores=num_stores+1
        if "stp" in line:
            num_stores=num_stores+2
        if "ldr" in line:
            num_loads=num_loads+1
        if "ldp" in line:
            num_loads=num_loads+2
        if "sp" in line and "str" in line:
            num_pop=num_pop+1
        if "sp" in line and "ldr" in line:
            num_push=num_push+1
        if "sp" in line:
            num_sp_arg=num_sp_arg+1
        if ":" in line and "//" not in line and ":pg" not in line:
            routines.append(line)

    print("Number of pushes:", num_push)
    print("Number of pops:", num_pop)
    print("Number of stores:", num_stores)
    print("Number of loads:", num_loads)
    print("Number of sp-related ops:", num_sp_arg)
    for r in routines:
        print(r)

if __name__ == "__main__":
   main(sys.argv)

