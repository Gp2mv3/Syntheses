class Tree
   attr value left right
   meth init(V) value := V left := leaf right := leaf end
   meth setLeft(T) left := T end
   meth setRight(T) right := T end
   meth setValue(V) value := V end
   meth getLeft($) @left end
   meth getRight($) @right end
   meth getValue($) @value end
   meth isBalanced($)
      local NumLeave L R X Y in
	 fun{NumLeave T}
	    local A B in
	       if {T getLeft($)} == leaf then A = 1
	       else A = {NumLeave {T getLeft($)}}
	       end
	       if {T getRight($)} == leaf then B = 1
	       else B = {NumLeave {T getRight($)}}  
	       end
	       A + B
	    end
	 end

	 if @right == leaf then R = true X = 1
	 else R = {@right isBalanced($)} X = {NumLeave @right}
	 end

	 if @left == leaf then L = true Y = 1
	 else L = {@left isBalanced($)} Y = {NumLeave @left}
	 end

	 ( (X-Y) < 2 andthen ~2 < (X-Y) andthen R andthen L )
      end
   end
end
