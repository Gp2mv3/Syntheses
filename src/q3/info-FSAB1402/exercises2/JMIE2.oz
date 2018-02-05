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
   meth enqueue(X) a := {Append @a [X]} end
   meth dequeue($) case @a of H|T then a := T H else raise badExpression(@a) end end
   end
end
