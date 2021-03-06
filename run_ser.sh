#!/bin/bash

#g++-5 windrose.cpp -o windrose -fopenmp -std=gnu++11 
#for parallel run wind.cpp
#export OMP_NUM_THREADS=4
#g++-4.9 -g wind.cpp -o windrose -fopenmp -std=gnu++11
#for serial
stationId="any"
export OMP_NUM_THREADS=1
g++-4.9 -g serial.cpp -o windrose -fopenmp -std=gnu++11
if [ $? -ne 0 ]
then
    echo "Compile failed!"
    exit 1
fi

curr_dir=$PWD
#find files in currdir with .csv extension recursively
file_list=""
for entry in $(find $curr_dir -type f -name "*.csv")
do
	file_list="$file_list $entry"
done
#echo $file_list
time ./windrose $stationId $file_list
#valgrind --tool=memcheck ./windrose $file_list
