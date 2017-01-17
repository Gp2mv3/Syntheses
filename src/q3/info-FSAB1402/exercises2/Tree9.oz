fun {Measure N}
   local A B C P Q in
      A = {GetRefTime}
      P = {NaiveRabbit N}
      B = {GetRefTime}
      Q = {Rabbit N}
      C = {GetRefTime}
    
      2 * B - A - C
   end
end