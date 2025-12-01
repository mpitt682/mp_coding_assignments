#!/usr/bin/env bash

df > df_output.txt 

declare -u header="The is the df command output in green and italic formatting"
echo $header

#declare -i lines=$(df | wc -l)
#echo $lines


echo -e "\033[1;34;40mLINE:\n\033[0m\033[3;32;40m$(cat df_output.txt)\033[0m"
