declare

% Added an accumulator to the GenericServer from Q7/8
% The function F receives every message AND the accumulator
% and should return the new accumulator after the message is dealt with
% The result of each step of the computation is returned as an element
% of the list Result so the final result is the last element of Result
fun {GenericServerWithAcc F InitA ?Result}
   In in
   thread
      fun {Loop Xs A}
	 case Xs
	 of Msg|Xr then NewA in
	    NewA = {F Msg A}
	    NewA|{Loop Xr NewA}
	 end
      end
   in
      Result={Loop In InitA}
   end
   {NewPort In}
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

% Actual function used by the server
fun {Counter M Xs}
   if M==e orelse M==m orelse M==c then {AddOccurence Xs M} 
   else raise wrongMessageException('message should be e,m or c') end
   end
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
Result
Server = {GenericServerWithAcc Counter nil Result}

% Send only one type per thread on purpose
% so we can understand the results
thread {SendMessages Server e|e|e|e|_ 1000 2000} end % Pipe 1 (kinda fast)
thread {SendMessages Server m|m|m|m|_ 3000 3500} end % Pipe 2 (slow)
thread {SendMessages Server c|c|c|c|_ 0 1000} end % Pipe 3 (fast)

{Browse Result}

% In the end, the final element of Result always contains
% the same elements, only the order of these elements can change
% depending on MinWait and MaxWait values for each thread.
% This is observable non-determinism in the strict sense, but
% the list can always be sorted afterward so the final user won't
% see any non-determinism.
