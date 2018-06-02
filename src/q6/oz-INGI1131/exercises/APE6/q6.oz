%Exo 6
declare
fun {Last Xs}
   case Xs of
      [X] then X
   [] X|Xr then {Last Xr}
   end
end
fun {Maximum Xs}
   {Last {InSort Xs}}
end
%Mettre insort et insert en lazy dans ce cas ne change rien car il faut de toute facon trier toute la liste pour acceder au maximum a la derniere position, apres le tri, ce qui arrivera meme si les fonctions insort et insert  sont lazy.