%Exo 7
declare
fun {NewCell X}
   X|_
end
proc{Access C R}
   if{Value.isDet C.2} then {Access C.2 R}
   else
      R=C.1
   end
end
proc{Assign C E}
   if{Value.isDet C.2} then {Assign C.2 E}
   else
      C.2=E|_
   end
end

declare
X={NewCell 5}
Y
Z
{Access X Y}
{Assign X 7}
{Access X Z}
{Browse Y|Z}