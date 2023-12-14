#!/bin/bash

set -x

sed -i '/^$/d' ./*txt

for file in 96*txt; do
	convert -interline-spacing 0 \
		-resize 450x \
		-font JetBrains-Mono-Light \
		-fill white \
		-background black \
		-pointsize 20 \
		label:@${file} \
		${file}.png
done

ffmpeg -y -framerate 1 -pattern_type glob -i '96_*.png' -c:v libx264 -pix_fmt yuv420p out.mp4
mpv out.mp4
