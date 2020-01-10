local F1 F3 in
   fun {F1 A}
      C = {NewCell A}
      fun {F2 B}
         C := @C + B
         @C
      end
   in
      fun {$ X}
         {F2 X+X}
      end
   end
   F3 = {F1 2}
   {Browse {F3 3}}
end