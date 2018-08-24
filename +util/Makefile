.PHONY: deriv clean

pdfbin=export TEXINPUTS=".:~/projects/tao:"; pdflatex

deriv:
	$(pdfbin) $@
	#$(pdfbin) $@
	#$(pdfbin) $@

clean:
	(GLOBIGNORE="deriv.m:deriv.tex:deriv.pdf"; rm -f deriv.* deriv-blx.*)

