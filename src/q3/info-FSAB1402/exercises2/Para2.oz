fun{DivIfNot5 N T}
   if (T mod 5 == 0) then error5
   else N div T
   end
end
fun{DivIfNot4 N T}
   X = {DivIfNot5 N T-1}
in if (T mod 4 == 0) then error4
   elseif {Int.is X} then X div T
   else X
   end
end
fun{DivIfNot3 N T}
   X = {DivIfNot4 N T-1}
in if (T mod 3 == 0) then error3
   elseif {Int.is X} then X div T
   else X
   end
end
fun{DivIfNot5E N T}
   if (T mod 5 == 0) then raise error5 end
   else N div T 
   end
end
fun{DivIfNot4E N T}
   X = {DivIfNot5E N T-1}
in if (T mod 4 == 0) then raise error4 end
   else X div T
   end
end
fun{DivIfNot3E N T}
   X = {DivIfNot4E N T-1}
in if (T mod 3 == 0) then raise error3 end
   else X div T
   end
end