#!/bin/bash

set -x

for i in tmp_*txt; do
	convert -interline-spacing -5 \
		-kerning 3 \
		-font JetBrains-Mono-Regular \
		-fill white \
		-background black \
		-pointsize 10 \
		label:@${i} ${i}.png
done

# mp4
exit 0
ffmpeg -y -framerate 15 -pattern_type glob -i 'tmp_*.png' -c:v libx264 -pix_fmt yuv420p out.mp4

# GIF
exit 0
convert -interline-spacing -5 \
	-kerning 3 \
	-font JetBrains-Mono-Regular \
	-fill white \
	-background black \
	-delay 5 \
	-pointsize 10 \
	$(
		a=(tmp*txt)
		printf 'label:@%s ' ${a[@]}
	) \
	tmp50.gif
