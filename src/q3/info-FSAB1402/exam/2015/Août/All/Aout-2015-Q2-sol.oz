local C AddMe I1 I8 R2 in
   I1=0
   {NewCell I1 C}
   AddMe=proc {$ N R}
	    local I2 I3 I7 in
	       I2=0
	       I3=N>I2
	       if I3 then
		  local I4 I5 I6 V1 V2 in
		     I4=@C
		     V1=1
		     V2=N-V1
		     {AddMe V2 I5}
		     I6=I4+I5
		     C :=I6
		  end
	       else skip end
	       I7=@C 
	       R=N+I7
	    end
	 end
   I8=5
   {AddMe I8 R2}
   {Browse R2}
end