#!/bin/bash
shopt -s nullglob
for file in *
do
	if [ -f "$file" ] || [ -d "$file" ]; then
		newfile=$(echo "$file" | sed -e 's/[A-Z]/\L&/g' -e 's/[[:space:]]/\-/g' -e 's/[_]/\-/g' -e 's/[áà]/a/' -e 's/[éè]/e/' -e 's/[íì]/i/' -e 's/[óò]/o/' -e 's/[úù]/u/'  -e 's/[ÁÀ]/A/' -e 's/[ÉÈ]/E/' -e 's/[ÍÌ]/I/' -e 's/[ÒÓ]/O/' -e 's/[ÚÙ]/U/')
		mv -f "$file" $newfile
	fi
done
