declare
local G
   C1={NewCell 1}
   C2={NewCell 2}
   fun {F A}
      C2={NewCell 4}
   in
      fun {$ B}
	 A+B+@C1+@C2
      end
   end
in
   C1 := @C1+8
   C2 := @C2+16
   G={F 32}
   {Browse {G 64}}
end