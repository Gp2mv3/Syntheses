meca.pdf: meca.tex
	pdflatex meca.tex

release: meca.pdf
	cp meca.pdf ../release

clean:
	@rm ./*.aux
	@rm ./*.log
