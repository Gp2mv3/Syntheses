declare
fun {NewStack}
   Stack = {NewCell nil}
   
   fun {IsEmpty}
      if @Stack == nil then true
      else false
      end
   end
   
   proc {Push X}
      Stack:=X|@Stack
   end
   
   fun {Pop}
      case @Stack of H|T then
	 Stack:=T
	 H
      else error
      end
   end
in
   stack(isEmpty:IsEmpty push:Push pop:Pop)
end




fun {Eval L}
   local A B S in
      A = {NewCell 0}
      B = {NewCell 0}
      S = {NewStack}
      for I in L do
	 case I of '+' then A:={S.pop} B:={S.pop} {S.push @A+@B}
	 [] '-' then A:={S.pop} B:={S.pop} {S.push @B-@A}
	 [] '*' then A:={S.pop} B:={S.pop} {S.push @A*@B}
	 [] '/' then A:={S.pop} B:={S.pop} {S.push (@B div @A)}
	 else {S.push I} end
      end
      {S.push}     
   end
end
