declare
fun {NewPortObject F Init}
   Xs
   P = {NewPort Xs}
   fun {Loop State Ms ?Left}
      M|Mr = Ms
      NewState
      Ok
   in
      try
         NewState = {F State M}
         Ok = true
      catch E then
         Left = Ms
         Ok = false
      end
      if Ok then
         {Loop NewState Mr Left}
      else
         true
      end
   end
   proc {TryToSurvive State Ms}
      Mr
   in
      if {Loop State Ms Mr} then
         {TryToSurvive dead Mr}
      end
   end
in
   thread {TryToSurvive Init Xs} end
   P
end

fun {NewPeer Next Id N}
   fun {DeterministicMap K}
      fun {Sum L Acc}
         case L
         of nil then Acc
         [] H|T then {Sum T Acc+H}
         end
      end
   in
      {Sum {Atom.toString K} 0} mod N
   end
   fun {F State M}
      {Browse Id#State#M#{DeterministicMap M.1}}
      if Id == 9 andthen ({OS.rand} mod 2) == 0 then
         raise diepotato end
      end
      if State == dead orelse {DeterministicMap M.1} \= Id then
         {Send Next M}
         State
      else
         case M
         of put(K V) then
            case State
            of empty then dictionary(K:V)
            else
               Ls
               NewState
            in
               {AdjoinAt State K V}
            end
         [] get(K X) then
            if {HasFeature State K} then
               X = State.K
            else
               X = none
            end
            State
         end
      end
   end
in
   {NewPortObject F empty}
end

fun {MakeNetwork N}
   fun {Fill Prev I}
      if I == N then
         Prev
      else
         {Fill {NewPeer Prev I N} I+1}
      end
   end
   First = {NewPeer {Fill First 1} 0 N}
in
   First
end

Root = {MakeNetwork 10}
{Send Root put(answer 42)}
{Send Root put(dont panic)}
X Y
{Send Root get(answer X)}
{Send Root get(question Y)}
{Browse X}
{Browse Y}