declare
fun lazy {Agent2 F Xs Ys}
   case Xs#Ys of (H|T)#(H2|T2) then
      {F H H2}|{Agent2 F T T2}
   end
end

fun lazy {Agent1 F Xs}
   case Xs of H|T then
      {F H}|{Agent1 F T}
   end
end

fun {ListToStream2 F Xs Ys}
   {Agent2 F Xs Ys}
end

fun {ListToStream1 F Xs}
   {Agent1 F Xs}
end

fun
   {AddList A B}
   case A#B of (Ha|Ta)#(Hb|Tb) then
      (Ha+Hb)|{AddList  Ta Tb}
   [] nil#nil then
      nil
   end
end

fun {ShiftLeft A}
   case A of nil then
      [0]
   [] H|T then
      H|{ShiftLeft T}
   end
end

fun {ShiftRight A}
   0|A
end

proc
   {Pascal ?Rs}
   Rs = {ListToStream1 fun {$ R} {AddList {ShiftLeft R} {ShiftRight R }}
	 end [1]|Rs}

end


Rs = {Pascal}
{Browse  Rs}
{Wait Rs.2.2.2.2.2}
