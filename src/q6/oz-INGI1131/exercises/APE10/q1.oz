declare
% The following code is not asked in the statement but in practice, it is ask during the lab session...

% Port object with internal state
fun {NewPortObject Init Fun}
   P
in
   thread Sin Sout in
      {NewPort Sin P}
      {FoldL Sin Fun Init Sout} %do Sout = {Fun {Fun {Fun {Fun Init S1} S2} S3} S4} if Sin = [S1 S2 S3 S4] then the first arg of Fun will always be the previous state
   end
   P
end

% Port object without internal state
fun {NewPortObject2 Proc}
   P
in
   thread Sin in
      {NewPort Sin P}
      for Msg in Sin do {Proc Msg} end
   end
   P
end

fun {Timer}
   {NewPortObject2
        proc {$ Msg}
            case Msg of starttimer(T Pid) then
            thread {Delay T} {Send Pid stoptimer} end
            end
        end}
end

fun {DishWasher Capacity}
    local
        MyTimer = {Timer}

        fun {MyFun State Msg}
            case Msg
                of dish(Accepted) then
                    if State < Capacity then
                        Accepted = true
                        State+1 % One item is added in the Dishwasher
                    else
                        Accepted = false
                        State % I ignore the plate that one tries to put into the full dishwasher
                    end
                [] glass(Accepted) then
                    if State < Capacity then
                            Accepted = true
                            State+1 % One item is added in the Dishwasher
                        else
                            Accepted = false
                            State % I ignore the plate that one tries to put into the full dishwasher
                        end
                [] start then {Send MyTimer starttimer(1000 P)} State
                [] stoptimer then 0
                else {Browse wrongMessage} State
            end
        end

        P = {NewPortObject 0 MyFun} % My initial state is the number of items in the dishwasher
    in
        P
    end
end

{Browse 'q1 test'}
T D A1 A2 A3 A4 A5
%T = {Timer2 D}
D = {DishWasher 3}
{Send D dish(A1)}
{Browse A1|true}
{Send D dish(A2)}
{Browse A2|true}
{Send D glass(A3)}
{Browse A3|true}
{Send D glass(A4)}
{Browse A4|false}
{Send D start}
{Delay 3000}
{Send D dish(A5)}
{Browse A5|true}
