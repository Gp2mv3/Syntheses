class Stack
   attr a
   meth init a := nil end
   meth size($) {List.length @a $} end
   meth isEmpty($) @a == nil end
   meth top($) case @a of H|T then H else raise badExpression(@a) end end end
   meth push(X) a := X|@a end
   meth pop($) case @a of H|T then a := T H else raise badExpression(@a) end end end
end
class Queue
   attr a
   meth init a := nil end
   meth size($) {List.length @a $} end
   meth isEmpty($) @a == nil end
   meth front($) case @a of H|T then H else raise badExpression(@a) end end end
   meth enqueue(X) local Dernier in
		      fun{Dernier L}
			 case L of H|T then
			    if T == nil then
			       H|X|nil
			    else H|{Dernier T}
			    end
			 else X|nil
			 end
		      end
		      a := {Dernier @a}
		   end
   end
   meth dequeue($) case @a of H|T then a := T H else raise badExpression(@a) end end
   end
end