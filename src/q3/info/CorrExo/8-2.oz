declare
fun {NewStack}
   {NewCell nil}
end

fun {IsEmpty S}
   if @S == nil then true
   else false
   end
end

proc {Push S X}
   S:=X|@S
end

fun {Pop S}
   case @S of H|T then
      S:=T
      H
   else error
   end
end

fun {Eval L}
   local A B C S in
      A = {NewCell 0}
      B = {NewCell 0}
      S = {NewStack}
      for I in L do
	 case I of '+' then A:={Pop S} B:={Pop S} {Push S @A+@B}
	 [] '-' then A:={Pop S} B:={Pop S} {Push S @B-@A}
	 [] '*' then A:={Pop S} B:={Pop S} {Push S @A*@B}
	 [] '/' then A:={Pop S} B:={Pop S} {Push S (@B div @A)}
	 else {Push S I} end
      end
      {Pop S}     
   end
end
