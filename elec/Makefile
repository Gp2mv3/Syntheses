elec.pdf: elec.tex
	pdflatex elec.tex

release: elec.pdf
	cp elec.pdf ../release

clean:
	@rm ./*.aux
	@rm ./*.log
