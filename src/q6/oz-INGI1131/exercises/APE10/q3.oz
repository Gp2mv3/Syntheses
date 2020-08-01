declare

% Port object with internal state
fun {NewPortObject Init Fun}
   P
in
   thread Sin Sout in
      {NewPort Sin P}
      {FoldL Sin Fun Init Sout}% fait Sout = {Fun {Fun {Fun {Fun Init S1} S2} S3} S4} si Sin = [S1 S2 S3 S4] donc le premier arg de Fun sera tjrs l'état d'avant
   end
   P
end

proc {Controller Msg}
    case Msg
    of step(Lid Pos Dest) then if Pos<Dest then
        {Delay 1000} {Send Lid 'at'(Pos+1)} elseif Pos>Dest then
        {Delay 1000} {Send Lid 'at'(Pos-1)} end
    end
end

fun {Lift Num Init Cid Floors}
    Lid in
    Lid = {NewPortObject Init
    fun {$ state(Pos Sched Moving) Msg}
            case Msg
            of call(N) then
                {Browse 'Lift '#Num#' needed at floor '#N}
                if N==Pos andthen {Not Moving} then
                    {Browse 'At '#N#' floor!'}
                    {Wait {Send Floors.Pos arrive($)}}
                    state(Pos Sched false)
                else Sched2 in
                    Sched2={ScheduleLast Sched N}
                    if {Not Moving} then
                    {Send Cid step(Lid Pos N)} end
                    state(Pos Sched2 true)
                end
            [] 'at'(NewPos) then
                {Browse 'Lift '#Num#' at floor '#NewPos}
                case Sched
                of S|Sched2 then
                if NewPos==S then
                    {Wait {Send Floors.S arrive($)}}
                    if Sched2==nil then
                        state(NewPos nil false)
                    else
                        {Send Cid step(Lid NewPos Sched2.1)}
                        state(NewPos Sched2 true)
                    end
                else
                    {Send Cid step(Lid NewPos S)}
                    state(NewPos Sched Moving)
                end
            end
         end
    end }
end




{Browse 'Test Lift 3'}
declare F L in
{Building 10 2 F L}
{Send F.9 call}
{Delay 300}
{Send F.5 call}
{Send L.1 call(4)}
{Send L.2 call(1)}
