#!/bin/bash
# Mick Zeller
# Lab2 - Search and Report
# CS 3030 - Scripting
if [ $# -ne 1 ]
then
        echo "Usage: srpt $PWD "
exit 1
fi


#variables
dir=$@
num_files=$( find $dir -type f | wc -l)
num_directories=$( find $dir -type d | wc -l)
num_symlinks=$( find $dir -type l | wc -l) #book says -h is symbolic link; i use it compilation error if i follow what is on the web -L or l nothing happens book says s can be used if using ln makes no reference to find command
jpg=$(find $dir -type f -iname *.jpg | wc -l)
bmp=$(find $dir -type f -iname *.bmp | wc -l)
gif=$(find $dir -type f -iname *.gif | wc -l)
num_pictures=$( expr $jpg + $bmp + $gif )
num_oldfile=$( find $dir -type f -mtime +365 | wc -l)
num_largefile=$( find $dir -type f -size +500000c | wc -l)
num_temp=$( find $dir -type f -name "*.o" | wc -l)
num_executable=$( find $dir -type f -perm 755 | wc -l)
total_size=$( find $dir -type f -ls | awk '{total+=5}END{print total}';)

#output
printf "SearchReport $HOSTNAME $@ $(date)"

printf "\n\nExecution time %'d\n" $SECONDS
printf "Directories %'d\n" $num_directories
printf "Files %'d\n" $num_files
printf "Sym links %'d\n" $num_symlinks
printf "Old files %'d\n" $num_oldfile
printf "Large files %'d\n" $num_largefile
printf "Graphics files %'d\n" $num_pictures
printf "Temporary files %'d\n" $num_temp
eof