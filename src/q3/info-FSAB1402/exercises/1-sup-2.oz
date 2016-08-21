local  Distance
   X1=3
   Y1=2
   X2=2.5
   Y2=0
in

   fun{Distance X1 Y1 X2 Y2}
      {Sqrt (X1-X2)*(X1-X2)+(Y1-Y2)*(Y1-Y2)}
   end
   {Browse {Distance X1 Y1 X2 Y2}}
end