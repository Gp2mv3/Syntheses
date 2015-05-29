declare
fun{DelayGate L}
   0|L
end

fun{XorGate A B}
   fun{XorLoop A B}
      case A#B of A1|A2#B1|B2 then
	 A1+B1-2*A1*B1|{XorLoop A2 B2}
      end
   end
   thread {XorLoop A B} end
end

fun {F A B} X in
   X = {Delay B}
   B = {XorGate X A}
end