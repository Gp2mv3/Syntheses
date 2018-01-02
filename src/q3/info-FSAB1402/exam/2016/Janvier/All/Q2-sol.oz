local C F P1 R3 R4 A1 I7 in A1=0
   {NewCell A1 C}
   F=proc{$ A R}
	R=proc{$ B R2}
	     local I1 I2 I3 in
		I1=@C
		I2=A+I1
		{B I3}
		R2=I3+I2
	     end
	  end
     end
   P1=proc{$ R5}
	 local I4 I5 I6 in
	    I4=@C
	    I5=1
	    I6=I4+I5
	    C:=I6
	    R5=@C
	 end
      end
   I7=1
   {F I7 R3}
   {R3 P1 R4}
   {Browse R4}
end
