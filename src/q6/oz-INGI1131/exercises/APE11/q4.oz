declare
fun {NewPortClose Xs}
   {NewCell Xs}
end
proc {Send P M}
   Xr
in
   if{Value.isFree @P} then
      {Exchange P M|Xr Xr} % Is ignored if it is closed because nil can't be matched with M|Xr
   end
end
proc {Close P}
   @P = nil
end

Xs
P = {NewPortClose Xs}

thread for I in 1..10 do {Send P I} {Delay 1} end {Close P} end
thread for I in 1..10 do {Send P I} {Delay 3} end end % The rest is not added since it is closed
{Browse Xs}