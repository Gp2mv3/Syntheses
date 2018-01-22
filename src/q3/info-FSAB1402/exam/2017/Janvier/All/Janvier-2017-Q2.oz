local
   fun {F A}
      C={NewCell 0}
   in
      fun {$ B}
         A-{B C}+{B C}
      end
   end
in
   {Browse {{F 1} fun {$ C} C:=@C+1 @C end}}
end
