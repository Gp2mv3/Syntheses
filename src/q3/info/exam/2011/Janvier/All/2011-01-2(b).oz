local G C1 C2 F N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 in
   N1=1
   N2=2
   {NewCell N1 C1}
   {NewCell N2 C2}
   
   F = proc {$ A ?Out}
	  local C2 N12 in
	     N12=4
	     {NewCell N12 C2}
	     Out = proc {$ B ?Out}
		      local N13 N14 N15 N16 in
			 N13=A+B
			 N14=@C1
			 N15=@C2
			 N16=N14+N15
			 Out=N13+N16
		      end
		   end
	  end
       end

   N3=8
   N4=16

   N5=@C1
   N6=@C2
   
   N7=N3+N5
   N8=N4+N6
   
   C1:=N7
   C2:=N8

   N9=32
   N10=64
   
   {F N9 G}
   {G N10 N11}
   {Browse N11}
end