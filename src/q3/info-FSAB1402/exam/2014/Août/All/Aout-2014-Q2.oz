local MakeCla MakeObj Obj1 Obj2 I1 RA1 RA2 RA3 RA4 in
   MakeCla=proc {$ R1}
      local D I2 in
	 I2 = 0
	 {NewCell I2 D}
	 R1=proc {$ R2}
	    local C I3 in
	       I3 = 0
	       {NewCell I3 C}
	       R2=proc {$ R3}
		  local I4 I5 I6 I7 I8 I9 in
		    I5=@D
		     I6 = 1
		     I4 = I5 + I6
		     D:= I4
		     I8=@C 
		     I9=@D 
		     I7 = I8 + I9
		     C:= I7
		     R3=@C 
		  end
	       end
	    end
	 end
      end
   end
   {MakeCla MakeObj}
   {MakeObj Obj1}
   {MakeObj Obj2}
   {Obj1 RA1}
   {Obj2 RA2}
   {Obj1 RA3}
   {Obj2 RA4}
   I1 = '|'(RA1 '|'(RA2 '|'(RA3 '|'(RA4 nil))))
   {Browse I1}
end