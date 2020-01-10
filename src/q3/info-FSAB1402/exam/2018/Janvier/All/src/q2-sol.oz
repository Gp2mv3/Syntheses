local F1 F3 in
   F1 = proc {$ A R1}
           local C F2 in
              {NewCell A C}
              F2 = proc {$ B R2}
                      local A1 A2 in
                         A1 = @C
                         A2 = A1 + B
                         C := A2
                         R2 = @C
                      end
                   end
              R1 = proc {$ X R3}
                      local A3 in
                         A3 = X+X
                         {F2 A3 R3}
                      end
                   end
           end
        end
   local A4 A5 A6 in
      A4 = 2
      {F1 A4 F3}
      A5 = 3
      {F3 A5 A6}
      {Browse A6}
   end
end