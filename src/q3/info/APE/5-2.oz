declare
fun {Modify BT F}
   fun {ModifyAux T}
      case T of leaf then leaf
      []tree(V left:L right:R) then tree({F V} left:{ModifyAux L} right:{ModifyAux R})
      end
   end
in
   {ModifyAux BT}
end

{Browse {Modify tree(42
		     left: tree(26
				left: tree(54
					   left: leaf
					   right: tree(18
						       left: leaf
						       right: leaf))
				right: leaf)
		     right: tree(37
				 left: tree(11
					    left: leaf
					    right: leaf)
				 right: leaf)) fun {$ V} V*2 end}}