.PHONY: all
all: day17.inputvis.test.pgm day17.inputvis.pgm day17.inputvis.png day17.inputvis.test.png day17.inputvis.spin.gif

# PGM
day17.inputvis.test.pgm: day17.inputvis.awk
	gawk -f $< data/day17.test.txt > $@
day17.inputvis.pgm: day17.inputvis.awk
	gawk -f $< data/day17.txt > $@

# PNG
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
	rm -f day17.inputvis.test.pgm day17.inputvis.pgm day17.inputvis.png day17.inputvis.test.png day17.inputvis.spin.gif
