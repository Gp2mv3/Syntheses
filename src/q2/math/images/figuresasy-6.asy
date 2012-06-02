if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="figuresasy-6";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

// Variables
import patterns;
unitsize(1inch);
pair A=(-1,-0.5),B=(1,-0.5),C=(1,0.5),D=(-1,0.5),E=(1.3,-0.25),F=(1.3,0.25);
// Points isolés
dot(E);
dot(F);
draw((0.7,0)--(1.9,0),invisible);
draw((1.3,-0.5)--(1.3,0.5),invisible);
viewportsize=(345.0pt,0);
