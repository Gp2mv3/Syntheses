declare
fun {NewPortObject F Init}
   Ms
   P = {NewPort Ms}
   proc {Loop Ms State}
      M|Mr = Ms
      NewState = {F M State}
   in
      {Loop Mr NewState}
   end
in
   thread {Loop Ms Init} end
   P
end

fun {NewCell Init}
   fun {F X State}
      case X
      of access(R) then R=State
      [] assign(E) then E
      end
   end
in
   {NewPortObject F Init}
end
proc {Access C ?R}
   {Send C access(R)}
end
proc {Assign C E}
   {Send C assign(E)}
end

X = {NewCell 0}
{Browse {Access X}}
{Assign X 2}
{Browse {Access X}}