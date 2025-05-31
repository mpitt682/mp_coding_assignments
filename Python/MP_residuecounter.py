#!/usr/bin/env python3

"""Assignment was to create a class that could count residues from a provided file. 
There is a corresponding test file mp_test_residues.py"""

class ResidueCounter():

    def __init__(self, residues=None):
        self.residues = residues

    def load_fasta(self, file_path):
        
        seqs_found = 0

        for line in open(file_path):
            line = line.rstrip()
        # Check if line is a fasta file header
            if line.startswith('>'):  
                if seqs_found == 0:   
                   seqs_found += 1
                
        # If more than one fasta sequence in file, throw an Exception
                else:
                    raise Exception("Error, expected a single-entry FASTA file but found more.")
                
            else:
                if self.residues is None:
                    self.residues = line
                else:
                    self.residues += line
                    
    
    def residue_count(self, residue):
        # Check that a fasta_load method was run first
        if self.residues is None:
            raise Exception("There are no residues to count. Please call the .load_fasta method first.")
        # Return a count of specified residue
        else:
            return self.residues.count(residue.upper())

    def residue_summary(self):
    # Create dictionary of each residue and their counts
        residue_dict = {}
        for residue in self.residues: 
            residue_dict[residue] = self.residues.count(residue)
    # Create table from residue dictionary    
        for key in residue_dict:
            print("Residue {0} = {1}".format(key, residue_dict[key]))
            
