if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="figuresasy-4";
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
path rect=A--B--C--D--cycle;
// Le rectangle
// vide
// La bordure
draw(A+(-0.01,-0.01)--B+(0.01,-0.01));
draw(D+(-0.01,+0.01)--C+(0.01,0.01));
draw(A+(-0.01,-0.01)--D+(-0.01,+0.01));
draw(B+(0.01,-0.01)--C+(0.01,0.01));
// Points isolés
dot(E);
dot(F);
