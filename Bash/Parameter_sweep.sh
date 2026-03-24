#!/usr/bin/env bash

# Bash script determines how changing the BWA-MEM seeded bases parameter (-W) would affect the average nucleotide content per cycle 
# of all the reads combined in a test data set. 

# Command to do parameter sweep for seeded bases
for i in 10 20 30 40 50 60 70 80 90; do bwa mem -W $i ~/tiny-test-data/genomes/Hsapiens/hg19/bwa/hg19.fa mt_1.fq.gz mt_2.fq.gz > mt_W$i.sam; done

# Command to extract ACGT content from stats output (multiple files)

# This iterates through each .sam file and generates samtools stats for each, selects the GCC stats (columns 2-7), 
# then sends it to a stats.txt file with the same name prefix as the .sam file.
for i in mt_W*.sam; do samtools stats "$i" | grep ^GCC | cut -f 2-7 > "${i%.sam}_stats.txt"; done

# Command to calculate average of each nucleotide column for A/C/T/G/N content per cycle
for f in mt_W*_stats.txt; do echo $f; awk '{ sumA += $2; sumC += $3; sumG += $4; sumT += $5; sumN += $6; n++} END {if (n > 0) print sumA/(NR), sumC/(NR), sumG/(NR), sumT/(NR), sumN/(NR);}' $f; done | sed 's/mt_W//' | sed 's/_stats.txt//'

# Iterates through each stats.txt file, ouputs the name of the file, 
# then runs awk where it assigns the sum of each column to variable names (sumA, sumC, etc.). 

# It then prints each variable sum divided by the number of rows (NR) to calculate the average nucleotide content
# per cycle with the specified seeded bases criteria integer.
