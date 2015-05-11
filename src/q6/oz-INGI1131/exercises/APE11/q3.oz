declare
fun {NewPort Xs}
   {NewCell Xs}
end
proc {Send P M}
   Xr
in
   {Exchange P M|Xr Xr}
end

Xs
P = {NewPort Xs}

thread for I in 1..10 do {Send P I} {Delay 1} end end
thread for I in 1..10 do {Send P I} {Delay 3} end end
{Browse Xs}
