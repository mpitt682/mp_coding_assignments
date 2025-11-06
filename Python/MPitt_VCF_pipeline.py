#!/usr/bin/python
# my python template using BASH commands for variant calling on a preset fasta file


import sys
import argparse
import subprocess

args = argparse.ArgumentParser(description="Maggie Pitt python pipeline script. Please install bwa, samtools, and bcftools to execute.")

#Arguments are to take as input a required first read, an optional second read, and an optional minimum variant call read depth for the final vcf file 
args.add_argument('-r1', '--read_1', type=str, required=True, help='Required FASTQ file for read 1')
args.add_argument('-r2', '--read_2', type=str, help='Optional FASTQ file for read 2')
args.add_argument('-dp', '--read_depth', type=int, default=1, help='Optional read depth cutoff to filter vcf results, default= 1')

parsed = args.parse_args()

#Saving the arguments as shorter variable names for inserting into the BASH commands
fq_reads = parsed.read_1 + ' ' + parsed.read_2
read_depth = str(parsed.read_depth)

#align read 1 (and read 2 if included) to hg19 reference genome in tiny-test-data file, wherever that file may be located in the home directory
subprocess.run("bwa mem ~/tiny-test-data/genomes/Hsapiens/hg19/bwa/hg19.fa " + fq_reads + " > fq_input.sam", stderr=subprocess.PIPE, shell=True)

#sort SAM file by name so it can be processed by samtools fixmate
subprocess.run("samtools sort -n fq_input.sam > fq_name_sorted.bam", stderr=subprocess.PIPE, shell=True)

#add mate score tags samtools markdup
subprocess.run("samtools fixmate -m fq_name_sorted.bam fq_fixmate.bam", stderr=subprocess.PIPE, shell=True)

#sort fixmate file by coordinates so samtools markdup can process file
subprocess.run("samtools sort -o fq_positionsort.bam fq_fixmate.bam", stderr=subprocess.PIPE, shell=True)

#remove marked duplicates with -r
subprocess.run("samtools markdup -r fq_positionsort.bam dups_removed.bam", stderr=subprocess.PIPE, shell=True)

#call variants on BAM file and save to VCF file
subprocess.run("bcftools mpileup -Ou -f ~/tiny-test-data/genomes/Hsapiens/hg19/seq/hg19.fa dups_removed.bam | bcftools call -vmO v -o fq.vcf", stderr=subprocess.PIPE, shell=True)

#save custom read depth value in filtered vcf file name
dp_filtered_vcf = "dp" + read_depth + "_filtered.vcf"

#filter variant calls for only those that meet the minimum read depth specified by the user, remove the header and save calls to new VCF file
subprocess.run("bcftools filter -e 'INFO/DP<" + read_depth + "' fq.vcf | grep -v '^#' > " + dp_filtered_vcf, stderr=subprocess.PIPE, shell=True)

#Output number of variants that meet read depth requirement
subprocess.run("echo Number of variants where read depth is at least " + read_depth + ": ; wc -l " + dp_filtered_vcf + " | sed 's/" + dp_filtered_vcf + "//'", stderr=subprocess.PIPE, shell=True)

#Output Average QUAL score for variants that meet read depth requirement
subprocess.run("echo Average QUAL score for variants where read depth is at least " + read_depth + ": ; awk '{ QUAL += $6; } END {print QUAL/(NR)}' " + dp_filtered_vcf, stderr=subprocess.PIPE, shell=True)

#Print name of VCF file where user can find more info about the filtered variants
print("Variant call file is " + dp_filtered_vcf)
