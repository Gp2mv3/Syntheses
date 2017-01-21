local A B C C1 C2 R1 R2 R3 R4 F1 F2 in
   A = 1
   B = 2
   C = 10
   {NewCell A C1}
   {NewCell B C2}
   F1 = proc {$ X R}
	   local Temp1 Temp2 in
	      Temp1 = @C2
	      Temp2 = Temp1 + X
	      C2 := Temp2
	      R =@C1
	   end
	end
   F2 = proc {$ X R}
	   local Temp1 Temp2 in
	      Temp1 = @C1
	      Temp2 = Temp1 + X
	      C1 := Temp2
	      R =@C2
	   end
	end
   {F2 C R1}
   {F1 R1 R2}
   {F2 C R3}
   {F1 R3 R4}
   {Browse R2}
   {Browse R4}
end