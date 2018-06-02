declare
fun {Filter L X}
   % returns L with all occurrences of X removed
   case L
   of H|T then
      if H == X then
         {Filter T X}
      else
         H|{Filter T X}
      end
   [] nil then
      nil
   end
end
fun {NewPortObject Init F}
   Xs
   P = {NewPort Xs}
   proc {Loop State Ms}
      M|Mr = Ms
   in
      {Loop {F State M} Mr}
   end
in
   thread {Loop Init Xs} end
   P
end
fun {NewAgent Next}
   fun {F C M}
      case M
      of packet(D) then
         OtherColors = {Filter {Filter [red blue green] C} D}
      in
         {Delay 420} % Test
         {Browse D}  % Test
         {Send Next packet(OtherColors.1)}
         D
      end
   end
in
   {NewPortObject red F}
end
proc  {Build ?A ?B ?C}
   A = {NewAgent B}
   B = {NewAgent C}
   C = {NewAgent A}
end
A B C
{Build A B C}
{Send A packet(blue)}