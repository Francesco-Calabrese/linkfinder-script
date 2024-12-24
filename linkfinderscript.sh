#!/bin/bash

function process_line(){
	echo "line: $1"

	if [ "$2" = "cli" ]; then
		python linkfinder.py -i $1 --output cli >> output_linkfinderscript
	else
		python linkfinder.py -i $1 
	fi
}

if [ $# -ne 2 ]; then
	echo "Usage $0 <list of urls> <options - either cli or gui>"
	exit 1
fi

if [ "$2" = "cli" ]; then
	echo -e "Printing output to the file: output_linkfinderscript\n"
	echo "" > output_linkfinderscript
else
	echo -e "Opening new items found in browser\n"
fi


line_num=0

words="$(wc -l $1)"
printf "Total lines in file: %s\n\n" "${words}"

while read line; do
	((line_num++))
	printf "$line_num "
	process_line "$line" $2
	sleep 3
done < $1

if [ "$2" = "cli" ]; then
	sort output_linkfinderscript | uniq > output_sorted
	rm output_linkfinderscript
	mv output_sorted output_linkfinderscript
fi

