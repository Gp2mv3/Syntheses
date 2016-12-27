fun {NumLeaves Tree}
   case Tree 
   of leaf then 1
   [] btree(1:X right:R left:L) then {NumLeaves R}+{NumLeaves L}
   else 0
   end
end