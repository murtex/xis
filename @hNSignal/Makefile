.PHONY: spline clean

pdfbin=export TEXINPUTS=".:~/projects/tao:"; pdflatex

spline:
	$(pdfbin) $@
	#$(pdfbin) $@
	#$(pdfbin) $@

clean:
	(GLOBIGNORE="spline.tex:spline.pdf"; rm -f spline.* spline-blx.*)

