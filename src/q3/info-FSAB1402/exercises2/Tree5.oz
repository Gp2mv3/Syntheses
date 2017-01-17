fun {IsBalanced Tree}
   B C
in
   case Tree
   of leaf then true
   [] btree(1:X right:R left:L) then B = {NumLeaves R}
      C = {NumLeaves L}
      ((B-C)<2 andthen (B-C) >~2 andthen {IsBalanced R} andthen {IsBalanced L})
   else false
   end
end