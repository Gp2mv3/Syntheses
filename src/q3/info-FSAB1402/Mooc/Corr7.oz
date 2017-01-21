local A B C R Add in
   proc {Add A C R} R = A+A+B+C end
   local D E F in
      D = 1
      E = 2
      {Add D E F} %1
   end
end