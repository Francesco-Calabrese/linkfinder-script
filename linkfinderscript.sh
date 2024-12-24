#!/bin/bash

function process_line(){
	echo "line: $1"
	python linkfinder.py -i $1 --output cli >> output_linkfinderscript
}

if [ $# -ne 1 ]; then
	echo "Usage $0 <list of urls>"
	exit 1
fi

line_num=0

echo -e "Printing output to the file: output_linkfinderscript\n"
echo "" > output_linkfinderscript

printf "Total lines in file: %d\n\n" "$(wc -l $1)"

while read line; do
	((line_num++))
	printf "$line_num "
	process_line "$line"
	sleep 2
done < $1

sort output_linkfinderscript | uniq > output_sorted
rm output_linkfinderscript
mv output_sorted output_linkfinderscript
