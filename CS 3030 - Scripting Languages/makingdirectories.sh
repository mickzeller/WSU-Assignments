#!/bin/bash



n=1;
max=10;
while [ "$n" -le "$max" ]; do
	mkdir "Lab $n"
	n=`expr "$n" + 1`;
done;
