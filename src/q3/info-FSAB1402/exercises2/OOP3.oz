class Addition
   attr a1 a2
   meth init(A B) a1 := A a2 := B end
   meth evaluate($) 
	 {@a1 evaluate(A)} + {@a2 evaluate(B)}
   end
end
class Subtraction
   attr a1 a2
   meth init(A B) a1 := A a2 := B end
   meth evaluate($)  
	 {@a1 evaluate($)} - {@a2 evaluate($)}
   end
end
class Multiplication
   attr a1 a2
   meth init(A B) a1 := A a2 := B end
   meth evaluate($)  
	 {@a1 evaluate($)} * {@a2 evaluate($)}
   end
end
class Division
   attr a1 a2
   meth init(A B) a1 := A a2 := B end
   meth evaluate($)  
	 {@a1 evaluate($)} div {@a2 evaluate($)}
      end
   end
end
class Constant
   attr x
   meth init(A) x := A end
   meth evaluate($) @x end
end
class Variable
   attr y
   meth init(A) y := A end
   meth set(A) y := A end
   meth evaluate($) @y end
end