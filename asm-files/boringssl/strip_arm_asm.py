# This is in no way good
# in fact, this is very bad

import sys, getopt

def main(argv):
    fin = open(argv[1], 'r')
    fout_name = "processed-" + argv[1]
    fout = open(fout_name, 'w')
    for line in fin:
        # take out comments at beginning
        if "//" in line and line[0]=='/':
            next
        elif "//" in line:
            new = line.split("//",1)[0]
            fout.write(new)
        else:
            fout.write(line)
    fout.close()

if __name__ == "__main__":
   main(sys.argv)

