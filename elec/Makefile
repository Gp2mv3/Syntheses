elec.pdf: elec.tex
	pdflatex elec.tex

release: elec.pdf
	cp elec.pdf ../release

clean:
	@$(RM) ./*.aux
	@$(RM) ./*.log
