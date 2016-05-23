%Exo 6

declare
fun {Filter X}
   if X == nil then nil
   elseif X.1 mod 2 ==0 then X.2.1|{Filter X.2.2}
   else X.1|{Filter X.2.2}
   end
end

local X Y Z in
   thread X={Producer 1}end
   thread Y={Filter X}end
   thread Z={Consumer X 0}end
   {Browse X}
   {Browse Y}
   {Browse Z}
end      