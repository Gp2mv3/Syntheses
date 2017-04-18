local F G C in
   C={NewCell 5}
   fun {F N}
      N+@C
   end
   fun {G K}
      {F K}+K
   end
   C := @C+2
   local C in
      C={NewCell 10}
      {Browse {G 2}}
   end
end