declare
fun {NewPortObject F Init}
   Xs
   proc {Loop State Ms}
      M|Mr = Ms
   in
      {Loop {F State M} Mr}
   end
   P = {NewPort Xs}
in
   {Browse Xs}
   thread {Loop Init Xs} end
   P
end
fun {Rand N}
   ({OS.rand} mod N)
end 
fun {MakeAgent Neighbors Mod}
   proc {SendIt N}
      {Delay 420}
      {Send Neighbors.({Rand 4}+1) ball(N)}
   end
   fun {F State Message}
      ball(N) = Message
   in
      {Browse State#N}
      case State
      of noprev then skip {SendIt N}
      [] M then if ((M mod Mod)+1) \= N then {SendIt N} end
      end
      N
   end
in
   {NewPortObject F noprev}
end

proc {MakeMap N}
   Rows = {MakeTuple row N}
in
   for I in 1..N do
      Rows.I = {MakeTuple col N}
   end
   for I in 1..N do
      for J in 1..N do
         Neighbors = {MakeTuple neigh 4}
      in
         Neighbors.1 = Rows.((I mod N)+1).J
         Neighbors.2 = Rows.(((I+N-2) mod N)+1).J
         Neighbors.3 = Rows.I.(((J) mod N)+1)
         Neighbors.4 = Rows.I.(((J+N-2) mod N)+1)
         Rows.I.J = {MakeAgent Neighbors I*J}
      end
   end
   for I in 1..N do
      for J in 1..N do
         {Send Rows.I.J ball((I-1)*N + J)}
      end
   end
end

% We can see that at the end, there is some ball left (for me with N = 3, it was 5,8) that are still being exchange
% We can say that they are not consecutive (mod 100).
{MakeMap 3}