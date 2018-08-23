local C AddMe in
   C={NewCell 0}
   fun {AddMe N}
      if N>0 then
	 C := @C+{AddMe N-1}
      else skip end
      N+@C
   end
   {Browse {AddMe 5}}
end