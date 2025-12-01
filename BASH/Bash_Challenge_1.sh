#!/usr/bin/env bash

# Store output from df command to a text file
df > df_output.txt 

#Create an uppercase header
declare -u header="The is the df command output in green and italic formatting"
echo $header

#optional command to count the number of lines
#declare -i lines=$(df | wc -l)
#echo $lines

# Output df in green and italic formatting
echo -e "\033[1;34;40mLINE:\n\033[0m\033[3;32;40m$(cat df_output.txt)\033[0m"
