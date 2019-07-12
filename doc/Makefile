all:
	make prun.html prun.pdf pplot.html pplot.pdf -j

%.pdf : %.md
	pandoc $< -s -o $@

%.html : %.md
	pandoc --mathjax $< -s -o $@

clean:
	rm -f *.pdf *.html
