declare
class Port
   attr ms
   meth init(Ms)
      % ms is not a Cell, its content is a cell
      ms:={NewCell Ms}
   end
   meth send(M)
      Mr
   in
      {Exchange @ms M|Mr Mr}
   end
end
fun {NewPort Ms}
   {New Port init(Ms)}
end
proc {Send P M}
   {P send(M)}
end

Ms
P = {NewPort Ms}

thread for I in 1..10 do {Send P I} {Delay 1} end end
thread for I in 1..10 do {Send P I} {Delay 3} end end
{Browse Ms}

class PortClose from Port
   meth close
      @@ms = nil
   end
end
fun {NewPortClose Ms}
   {New PortClose init(Ms)}
end
proc {Close P}
   {P close}
end

Ns
Q = {NewPortClose Ns}

thread for I in 1..10 do {Send Q I} {Delay 1} end end
thread for I in 1..10 do {Send Q I} {Delay 3} end end

{Delay 5}
{Close Q}

{Browse Ns}