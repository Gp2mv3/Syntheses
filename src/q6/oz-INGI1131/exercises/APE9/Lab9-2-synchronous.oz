% Author: Francois Robinet
declare

%%% FIRST IMPLEMENTATION - Synchronous
% Charlotte waits for reply (reply is simply the student binding a variable)
% before polling the next student. We only have one thread so if one student
% takes a long time to reply we have to wait.
%
% To solve this, we could use a slightly more complicated approach.
% we can create a list of unbound variable the size of the University list
% and then ask each student to bind one of the unbound variables of the list.
% We then start our computation, iterating through the list and wait on variables
% that aren't bound yet. With this technique, you don't have to wait for
% the reply of a student to start polling the others, but you still have
% to wait for reply 4 before processing reply 5 etc, so it's not a complete solution.
% The asynchronous version is better at this.
fun {CreateUniversitySync Size}
   fun {StudentSync}
      S in
      thread
	 for ask(howmany:Beers) in S do Beers={OS.rand} mod 24 end
      end
      {NewPort S}
   end
   fun {CreateLoop I}
      if I =< Size then {StudentSync}|{CreateLoop I+1}
      else nil end
   end
in
   {CreateLoop 1}
end

fun {CharlotteSync University}
   fun {Loop University State}
      case University#State
      of nil#_ then State
      [] (Student|Ur)#stats(students:S beers:B average:A min:MIN max:MAX)
      then Beers NewState in
	 {Send Student ask(howmany:Beers)}
	 {Browse 'a student drank '#Beers#' beers'} % For test verification
	 % NewState needs Beers so this is waiting for Student's reply
	 NewState=stats(students:S+1 beers:B+Beers
			average:(A*{IntToFloat S}+{IntToFloat Beers})/{IntToFloat (S+1)}
			min:{Min MIN Beers} max:{Max MAX Beers})
	 {Loop Ur NewState}
      end
   end
in
   % Note: initial min is 23 because students can drink 0 to 23 beers
   {Loop University stats(students:0 beers:0 average:0.0 min:23 max:0)}
end

% TEST
{Browse {CharlotteSync {CreateUniversitySync 7}}}


