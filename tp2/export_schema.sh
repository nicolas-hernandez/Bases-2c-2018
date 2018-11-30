#!/usr/bin/bash

mkdir -p schemas/

for json_file in export/*.json; do
	filename=$(basename ${json_file})
	filename=${filename%.json}
	echo "Generating ${filename} json schema"
	python2 generate_schema.py < ${json_file} > schemas/${filename}.schema.json
done
