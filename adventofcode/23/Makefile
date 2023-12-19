.PHONY: all
all: day17.inputvis.png day17.inputvis.test.png day17.inputvis.spin.gif day18.gold.vis.pbm.png day18.silver.vis.pbm.png

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
day17.inputvis.test.pgm: day17.inputvis.awk
	gawk -f $< data/day17.test.txt > $@
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
day17.inputvis.test.png: day17.inputvis.test.pgm
	convert $< -filter point -resize 500x $@

.PHONY: clean
clean:
	rm -f day17.inputvis.test.pgm day17.inputvis.pgm day17.inputvis.png day17.inputvis.test.png day17.inputvis.spin.gif day18.silver.vis.pbm* day18.gold.vis.pbm*
