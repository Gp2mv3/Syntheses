local
   C={NewCell 0}
   fun {M D}
      D:=@D+1
      proc {$ X} X=@C+@D end
   end
   R
in
   {{M C} R}
   {Browse R}
end