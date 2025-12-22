#!/usr/bin/env bash

# CHALLENGE: nameemailavg.csv has names, email addresses, and bowling averages for 19 bowlers
# addresses.txt has hundreds of names and addresses, including the 19 bowlers
# output a tab-delimited file with the each bowler's name, mailing address, and average (2 decimal places)


# Convert comma-separated nameemailavg.csv file to tab-separated file with only name($1) and average($3)
awk -F , 'BEGIN{OFS="\t"} {print $1, $3}' nameemailavg.csv > nameemailavg.txt

# Combine the two files into one txt file with nameemailavg going first
awk 'BEGIN{FS="\t"} {print}' nameemailavg.txt addresses.txt > bowlerinfo.txt

# Create an array based on the names (key) and averages (value) for any line with only 2 fields (nameemailavg)
# Once the array is created, check if the fullname from addresses.txt ($1 and $2) is in the names array
# If the address line name matches a bowler's name, output the fullname, address, and bowling avg with spacing

awk 'BEGIN{
	FS="\t"
} 
{ 
	if (NF==2) { 
		names[$1] = $2 
	} else {
		fullname=$1 " " $2;
		
		address=$4 ", " $5 ", " $7 " " $8;
		if (fullname in names) {
			printf("%-20s\t%-50s\t%3.2f\n", fullname, address, names[fullname])
		}
	}
}' bowlerinfo.txt > nameaddavg.txt
