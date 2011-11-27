meca.pdf: meca.tex
	pdflatex meca.tex

release: meca.pdf
	cp meca.pdf ../release

clean:
	@$(RM) ./*.aux
	@$(RM) ./*.log
