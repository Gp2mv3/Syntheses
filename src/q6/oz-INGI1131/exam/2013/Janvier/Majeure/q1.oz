declare
proc {LiftToStream2 F Xs Ys ?Zs}
   proc {Loop Xs Ys ?Zs}
      X|Xr = Xs
      Y|Yr = Ys
      Z Zr
   in
      {WaitNeeded Zs}
      Z|Zr = Zs
      Z = {F X Y}
      {Loop Xr Yr Zr}
   end
in
   thread {Loop Xs Ys Zs} end
end
proc {LiftToStream1 F Xs ?Zs}
   proc {Loop Xs ?Zs}
      X|Xr = Xs
      Z Zr
   in
      {WaitNeeded Zs}
      Z|Zr = Zs
      Z = {F X}
      {Loop Xr Zr}
   end
in
   thread {Loop Xs Zs} end
end
fun {AddList A B}
   case A#B
   of (Ha|Ta)#(Hb|Tb) then (Ha+Hb)|{AddList Ta Tb}
   [] nil#nil then nil
   end
end
fun {ShiftLeft A}
   case A
   of nil then [0]
   [] H|T then H|{ShiftLeft T}
   end
end
fun {ShiftRight A}
   0|A
end
proc {Pascal ?Rs}
   Rs = {LiftToStream1 fun {$ R} {AddList {ShiftLeft R} {ShiftRight R}} end
         [1]|Rs}
end

Rs = {Pascal}
{Browse Rs}
{Wait Rs.2.2.2.2.2}