%Exo 5
declare
fun lazy{Insert X Ys}
   {Browse 3}
   case Ys of
      nil then [X]
   [] Y|Yr then
      if X < Y then
	 X|Ys
      else
	 Y|{Insert X Yr}
      end
   end
end
fun lazy {InSort Xs} %% Sorts list Xs
   {Browse 2}
   case Xs of
      nil then nil
   [] X|Xr then
      {Insert X {InSort Xr}}
   end
end
fun {Minimum Xs}
   {InSort Xs}.1
end
local X Y in
   X = 5|1|nil
   Y={Minimum X}
   {Browse Y}
end

%n+1 insort et O(n.n) insert dependant de l'ordre de la liste.
%avec insort et insert lazy, on a moins d'insert, il y a desormais autant d'insert que d'elem dans la liste (n+1 insort et n insert) --> ne trie pas la liste en entier, trouve uniquement le premier element (cf definition de minimum).