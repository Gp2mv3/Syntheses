local
   C={NewCell 0}
   fun {MC E}
      D={NewCell 1}
      proc {MC2 P C} {P C} end
   in
      E :=@E+1
      {MC2 proc {$ D} D :=@D+10 end C}
      @D
   end
in
   {Browse {MC C}}
   {Browse @C}
end
