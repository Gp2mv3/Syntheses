local
   C1 = {NewCell 1}
   C2 = {NewCell 2}
   fun{F1 X}
      C2 := @C2+X
      @C1
   end
   fun{F2 X}
      C1 := @C1 + X
      @C2
   end
in
   {Browse {F1 {F2 10}}}
   {Browse {F1 {F2 10}}}
end