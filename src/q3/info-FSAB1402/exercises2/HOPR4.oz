local
   fun {Fun1 X}
      X*1
   end
   fun {Fun2 X}
      X*2
   end
   fun {Fun3 X}
      X*3
   end
   FunL = [Fun1 Fun2 Fun3]
   L = [1 2 3]
   SolL = [1 4 9]
in
   {Test FunL L SolL}
end