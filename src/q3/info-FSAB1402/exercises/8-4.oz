
declare
fun{Shuffle L}
   A N M F
in
   A={NewArray 1 {Length L} 1}        %array a creer
   N={NewCell {Length L}}             %compteur1
   M={NewCell {Length L}}             %compteur2
   F={NewCell nil}                    %liste a renvoyer
   
   for I in L do 
      A.@N:=I                         %copier la liste
      N:=@N-1                         %adapter compteur
   end
  
   
   for J in L do
      C
   in
      C={Abs {OS.rand} mod @M} + 1
      F:=A.C|@F                       %ajouter un elelement au hasard
      A.C:=A.@M                       %recuperer le dernier element de la l'array
      M:=@M-1                         %adapter compteur
   end
   %refaire une liste au hasard
   
   @F 
end

{Browse {Shuffle [a b c d e]}}   % peut afficher [d c a b e]
