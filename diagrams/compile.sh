#!/bin/bash
cp -r diagrams out/diagrams
cd out/diagrams
rm compile.sh
for f in $(find -name '*.uxf')
do 
	echo "$f"
	output=${f%.uxf}.pdf
	echo "$output"
	/Umlet/umlet.sh -action=convert -format=pdf -filename="$f" -output="$output"
	rm "$f"
done
