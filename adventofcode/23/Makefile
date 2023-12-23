.PHONY: all
all: day17.inputvis.png day17.inputvis.spin.gif day18.gold.vis.pbm.png day18.silver.vis.pbm.png

# Day 23

DAY23SILVER=$(wildcard day23.silver*txt)

# for i in day23*pbm; do convert $i -filter point -resize 500x $i.png; done
day23.silver.mp4:
	ffmpeg -y -framerate 20 -pattern_type glob -i 'day23.silver*.png' -vf "loop=loop=100:size=100:start=252"  -c:v libx264 -pix_fmt yuv420p $@

day23.silver.test.png: data/day23.test.txt
	convert -font JetBrains-Mono-Regular -interline-spacing -10 -kerning 0 -fill white -background black -pointsize 14 "label:@$<" $@
day23.silver.png: data/day23.txt
	convert -font JetBrains-Mono-Regular -interline-spacing -8 -kerning 3 -fill white -background black -pointsize 14 "label:@$<" $@

# Day 21

day21.silver.1.jpg: data/21/step1.txt
	convert -font JetBrains-Mono-Regular -interline-spacing -5 -kerning 1 -fill white -background black -pointsize 14 "label:@$<" $@
day21.silver.2.jpg: data/21/step2.txt
	convert -font JetBrains-Mono-Regular -interline-spacing -5 -kerning 1 -fill white -background black -pointsize 14 "label:@$<" $@
day21.silver.3.jpg: data/21/step3.txt
	convert -font JetBrains-Mono-Regular -interline-spacing -5 -kerning 1 -fill white -background black -pointsize 14 "label:@$<" $@
day21.silver.4.jpg: data/21/step4.txt
	convert -font JetBrains-Mono-Regular -interline-spacing -5 -kerning 1 -fill white -background black -pointsize 14 "label:@$<" $@
day21.silver.5.jpg: data/21/step5.txt
	convert -font JetBrains-Mono-Regular -interline-spacing -5 -kerning 1 -fill white -background black -pointsize 14 "label:@$<" $@
day21.silver.test.png: day21.silver.1.jpg day21.silver.2.jpg day21.silver.3.jpg day21.silver.4.jpg day21.silver.5.jpg
	montage -background black -geometry +3+2 $^ $@
day21.silver.png: data/day21.txt
	convert -font JetBrains-Mono-Regular -interline-spacing -8 -kerning 3 -fill white -background black -pointsize 14 "label:@$<" $@

# Day 18

day18.gold.vis.pbm: day18.gold.vis.awk
	gawk -v div=10000 -f $< data/day18.txt > day18.gold.vis.pbm
day18.gold.vis.pbm.png: day18.gold.vis.pbm
	convert $< -filter point -rotate 270 $@

day18.silver.vis.pbm: day18.silver.vis.awk
	gawk -f $< data/day18.txt
day18.silver.vis.pbm.png: day18.silver.vis.pbm
	convert $< -filter point -rotate 270 -resize 800x $@

# Day 17

day17.inputvis.pgm: day17.inputvis.awk
	gawk -f $< data/day17.txt > $@
day17.inputvis.spin.gif: day17.inputvis.pgm
	convert $< -filter point             -resize 800x tmp1.png
	convert $< -filter point -rotate 90  -resize 800x tmp2.png
	convert $< -filter point -rotate 180 -resize 800x tmp3.png
	convert $< -filter point -rotate 270 -resize 800x tmp4.png
	convert tmp*.png -delay 10 $@
	rm -f ./tmp*.png
day17.inputvis.png: day17.inputvis.pgm
	convert $< -filter point -resize 1920x $@

.PHONY: clean
clean:
	rm -f day17.inputvis.pgm day17.inputvis.png day17.inputvis.spin.gif day18.silver.vis.pbm* day18.gold.vis.pbm*
