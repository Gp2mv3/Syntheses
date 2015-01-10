declare
fun {Promenade BT}
   fun {PromenadeAcc T Acc}
      case T of empty then Acc
      []btree(V left:L right:R) then V|{Append {PromenadeAcc L nil} {PromenadeAcc R nil}}
      end
   end
in
   {PromenadeAcc BT nil}
end

{Browse {Promenade btree(42
			 left: btree(26
				     left: btree(54
						 left: empty
						 right: btree(18
							      left: empty
							      right: empty))
				     right: empty)
			 right: btree(37
				      left: btree(11
						  left: empty
						  right: empty)
				      right: empty))}}%% affiche [42 26 54 18 37 11]
