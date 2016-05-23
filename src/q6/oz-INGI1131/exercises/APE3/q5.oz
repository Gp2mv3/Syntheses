%Exo 5

declare
fun {Producer X}
   X|{Producer X+1}
end

declare
fun{Consumer Y Z}
   if Y==nil then Z
   else {Consumer Y.2 Z+Y.1}
   end
end

local X Y in
   thread X={Producer 1}end
   thread Y={Consumer X 0}end
   {Browse X}
   {Browse Y}
end