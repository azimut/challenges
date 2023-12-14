#!/bin/bash

INPUT=day10vis.gold.txt

sed -i '/^$/d' ${INPUT}

convert -interline-spacing -15 \
	-font JetBrains-Mono-Regular \
	-fill white \
	-background black \
	-pointsize 20 \
	label:@${INPUT} \
	${INPUT}.png

#sxiv ${INPUT}.png
