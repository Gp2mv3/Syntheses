fun {FromListToTree L}
   fun {Add V Tree}
      case Tree of btree(1:X left:L right:R) then
	 if V<X then btree(1:X right:R left:{Add V L})
	 elseif V>X then btree(1:X right:{Add V R} left:L)
	 else Tree
	 end
      else btree(1:V left:leaf right:leaf)
      end
   end
   fun {Boucl L Tree}
      case L 
      of H|T then {Boucl T {Add H Tree}}
      else Tree
      end
   end
in
   case L
   of H|T then {Boucl T btree(1:H left:leaf right:leaf)}
   else leaf
   end
end
