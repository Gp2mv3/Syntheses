local F P R4 R5 I8 in
   F=proc{$ A R}
      local C I1 in
         I1=0
         {NewCell I1 C}
         R=proc{$ B R2}
            local I2 I3 I4 in
               {B C I2}
               I4=A-I2
               {B C I3}
               R2=I4+I3
            end
         end % proc {R B R2}
      end % local C I1
   end % proc {F A R}
   P=proc{$ C R3}
      local I5 I6 I7 in
         I5=@C
         I6=1
         I7=I5+I6
         C:=I7
         R3=@C
      end
   end % proc {P C R3}
   I8=1
   {F I8 R4}
   {R4 P R5}
   {Browse R5}
end
