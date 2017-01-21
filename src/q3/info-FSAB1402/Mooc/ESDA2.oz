if L == nil then nil
else
   local Length A L2 in
      {List.length L Length}
      A = {NewArray 1 Length 0}
      L2 = {NewCell nil}

      for J in 1..Length do
	 local Na in
	    {List.nth L J Na}
	    A.J := Na
	 end
      end
	 
      for J2 in 1..Length do
	 local I J in
	    J = Length + 1 - J2
	    I = {Number.abs ({OS.rand} mod J) } + 1
	    L2 := A.I|@L2
	    A.I := A.J
	 end
      end
	 
      @L2
   end
end