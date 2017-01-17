local C D Temp1 Temp2 F1 F2 R1 R2 in
   Temp1 = 1
   {NewCell Temp1 C}
   Temp2 = 2
   {NewCell Temp2 D}
   F1 = proc{$ C}
	   local T1 T2 in
	      T1 = @C
	      T2 = 4
	      C := T1 + T2
	   end
	end
   F2 = proc{$ D}
	   local T1 T2 T3 T4 in
	      T1 = @C
	      T2 = 8
	      C := T1 + T2
	      T3 = @D
	      T4 = 16
	      D := T3 + T4
	   end
	end
   {F1 D}
   {F2 C}
   R1 = @C
   R2 = @D
   {Browse R1}
   {Browse R2}
end
