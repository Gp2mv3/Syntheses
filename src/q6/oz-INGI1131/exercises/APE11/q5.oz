declare
fun {Q A B}
   Sum = {NewCell 0}
in
   for I in A..B do
      Sum := @Sum + I
   end
   @Sum
end
{Browse {Q 2 10}}