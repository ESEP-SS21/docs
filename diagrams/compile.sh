#!/bin/bash
cd ..
rm -rf out/diagrams || true
mkdir -p out

cp -r diagrams out/diagrams
cd out/diagrams
rm compile.*
for f in $(find -name '*.uxf')
do
	echo "$f"
	output=${f%.uxf}.pdf
	echo "$output"
	/Umlet/umlet.sh -action=convert -format=pdf -filename="$f" -output="$output"
	rm "$f"
done