%classe Sequence (Question 1)
class Sequence
   attr a1
   meth init a1 := nil end
   meth isEmpty($) if @a1 == nil then true else false end end
   meth first($) case @a1 of H|T then H else nil end end
   meth last($) 
      local Last in
	 fun{Last L}
	    case L
	    of H|nil then H
	    []H|T then {Last T}
	    else L
	    end
	 end
	 {Last @a1}
      end
   end
   meth insertFirst(X) a1 := X|@a1 end
   meth insertLast(X) a1 := {Append @a1 [X]} end
   meth removeFirst a1 := @a1.2 end
   meth removeLast
      local Last in 
	 fun{Last L}
	    case L
	    of H|nil then nil
	    [] H|T then H|{Last T}
	    else nil
	    end
	 end
	 a1 := {Last @a1}
      end
   end
end
%fonction Palindrome (Question 2)
fun {Palindrome Xs}
   S = {New Sequence init}
   for E in Xs do
      {S insertFirst(E)}
   end

   fun {Check}
      if {S isEmpty($)} then true
      else
	 if {S first($)} == {S last($)} then
	    {S removeFirst}
	    {S removeLast}
	    {Check}
	 else
	    false
	 end
      end
   end
in
   {Check}
end
