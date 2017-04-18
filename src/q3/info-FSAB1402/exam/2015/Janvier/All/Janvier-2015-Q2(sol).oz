local C I1 M R R1 in
   I1=0
   {NewCell I1 C}
   M=proc{$ D Res}
	local I2 I3 I6 in
	   I2=@D
	   I3=1
	   I6=I2+I3
	   D:=I6
	   Res=proc{$ X}
		  local I4 I5 in
		     I4=@C
		     I5=@D
		     X=I4+I5
		  end
	       end
	end
     end
   {M C R1}
   {R1 R}
   {Browse R}
end