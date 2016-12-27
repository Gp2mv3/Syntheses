fun {Prefix L1 L2}
   if L1 == nil then true
   elseif L1.1 == L2.1 then {Prefix L1.2 L2.2}
   else false
   end
end

fun {FindString L1 L2}
   if L1 == nil then true
   elseif L2== nil then false
   elseif {Prefix L1 L2} then true
   else {FindString L1 L2.2}
   end
end