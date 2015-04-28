% Author: Francois Robinet
declare

% Modified to return ports(in out)
% and write outputs to out
fun {NewPortObject Transition Init}
   proc {MsgLoop In State}
      case In
      of nil then skip
      [] Msg|Inr then NewState in
	 NewState={Transition Msg State}
	 {Send OutPort NewState}
	 {MsgLoop Inr NewState}
      end
   end
   In Out OutPort
in
   thread {MsgLoop In Init} end
   OutPort = {Port.new Out}
   ports('in':{Port.new In} out:Out)
end

% Helper function to add a person from type O
% to the list Xs
fun {AddOccurence Xs O}
   case Xs
   of nil then [O#1]
   [] (R#Y)|Xr then
      if O==R then (R#Y+1)|Xr
      else (R#Y)|{AddOccurence Xr O} end
   end
end

fun {Transition M State}
   if M==e orelse M==m orelse M==c then {AddOccurence State M} 
   else raise wrongMessageException('message should be e, m or c') end
   end
end

fun {Counter ?Output}
   In Out in
   ports('in':In out:Out)={NewPortObject Transition nil}
   Output=Out
   In
end

%%%% TESTS %%%%%
% I use this function for testing
% It sends each message of the list Xs
% to the port P, waiting a time randomly picked from [MinWait, MaxWait[ (in ms)
proc {SendMessages P Xs MinWait MaxWait}
   for X in Xs do
      if MinWait == MaxWait then {Delay MaxWait}
      else T in
	 T={OS.rand} mod (MaxWait-MinWait) + MinWait
	 {Delay T}
      end
      {Send P X}
   end 
end

% Initialisation
Out
C={Counter Out}
{Browse Out}

% Send only one type per thread on purpose
% so we can understand the results
thread {SendMessages C e|e|e|e|_ 1000 2000} end % Pipe 1 (kinda fast)
thread {SendMessages C m|m|m|m|_ 3000 3500} end % Pipe 2 (slow)
thread {SendMessages C c|c|c|c|_ 0 1000} end % Pipe 3 (fast)

