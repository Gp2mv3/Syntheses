declare
fun {Infix Tree}
   case Tree of leaf(V) then [V]
   [] tree(T1 T2) then
      {Append {Infix T1} {Infix T2}}
   end
end


{Browse {Infix tree(leaf(1)
		    tree(tree(tree(leaf(2)
				   tree(leaf(3)
					leaf(4)))
			      leaf(5))
			 leaf(6)))}}
% affiche [1 2 3 4 5 6].