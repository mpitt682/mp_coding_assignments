#!/usr/bin/env python3

import residuecounter

def main():
    print("TEST WITH NUCLEOTIDE FASTA FILE")
    rc1 = residuecounter.ResidueCounter()
    rc1.load_fasta("test_fasta.fna")
    res = input("Enter nucleotide residue: ")
    print("Residue count for {0}: {1}".format(res, str(rc1.residue_count(res))))
    rc1.residue_summary()

    print("\nTEST WITH AMINO ACID FASTA FILE")
    rc_aa = residuecounter.ResidueCounter()
    rc_aa.load_fasta("test_fasta.faa")
    res = input("Enter amino acid residue: ")
    print("Residue count for {0}: {1}".format(res, str(rc_aa.residue_count(res))))
    rc_aa.residue_summary()

    
    print("\nTEST FASTA FILE WITH TWO ENTRIES")
    rc3 = residuecounter.ResidueCounter()
    rc3.load_fasta("test_2_fastas.fna")

    print("\nTEST CALLING RESIDUE COUNTER BEFORE LOADING FASTA FILE")
    rc4 = residuecounter.ResidueCounter()
    res = input("Enter nucleotide or amino acid residue: ")
    print("Residue count for {0}: {1}".format(res, str(rc4.residue_count(res))))



if __name__ == '__main__':
    main()


