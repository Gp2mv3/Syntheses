local F G C Tmp1 Tmp6 Tmp4 Tmp5 in
   Tmp1 = 5
   {NewCell Tmp1 C}
   F= proc {$ N R1}
      local Tmp2 in
	 Tmp2=@C
	 R1 = N + Tmp2
      end
   end
   G=proc {$ K R2}
      local Tmp3 in
	 {F K Tmp3}
	 R2 = Tmp3 + K
      end
   end
   Tmp4=@C
   Tmp5 = 2
   Tmp6 = Tmp4 + Tmp5
   C:=Tmp6
   local C Tmp7 Tmp8 Tmp9 in
      Tmp7 = 10
      {NewCell Tmp7 C}
      Tmp8 = 2
      {G Tmp8 Tmp9}
      {Browse Tmp9}
   end
end