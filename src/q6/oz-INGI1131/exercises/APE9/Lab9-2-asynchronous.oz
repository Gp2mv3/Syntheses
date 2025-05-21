% Author: Francois Robinet
declare

%%% SECOND IMPLEMENTATION - Asynchronous
% Now the server poll each student but doesn't wait for his reply.
% It gives the student a callback Port where they have to send their
% reply. Charlotte doesn't know or care about the order of the replies
% so this works fine.
%
% The port function only needs to wait until AskLoop has sent
% a message to every student because PortLoop needs NumberOfStudent
% to be bound so it can stop and return its result when every student replied.
% This is ok because AskLoop shouldn't take much time since no calculation is done there
% If Send calls tooks time, we could still write 'NumberOfStudents={Length University}
% instead of letting AskLoop compute that.
fun {CreateUniversityAsync Size}
   fun {StudentAsync}
      S in
      thread
	 for ask(howmany:P) in S do {Send P {OS.rand} mod 24} end
      end
      {NewPort S}
   end
   fun {CreateLoop I}
      if I =< Size then {StudentAsync}|{CreateLoop I+1}
      else nil end
   end
in
   {CreateLoop 1}
end

fun {CharlotteAsync University}
   fun {AskLoop University NumberOfStudent}
      case University
      of nil then NumberOfStudent
      [] Student|Rest then
	      {Send Student ask(howmany:P)}
	      {AskLoop Rest  NumberOfStudent+1}
      end
   end
   fun {PortLoop In State}
      case In#State
      of (Beers|Inr)#stats(students:S beers:B average:A min:MIN max:MAX)
         then NewState in
            {Browse 'a student drank '#Beers#' beers'}
            NewState=stats(
               students:S+1 beers:B+Beers
               average:(A*{IntToFloat S}+{IntToFloat Beers})/{IntToFloat (S+1)}
               min:{Min MIN Beers} max:{Max MAX Beers})
            if NewState.students == NumberOfStudents then NewState
            else {PortLoop Inr NewState} end
      end
   end
   P In NumberOfStudents R
in
   thread
      Init = stats(students:0 beers:0 average:0.0 min:23 max:0) in
      R={PortLoop In Init}
   end
   P = {NewPort In}
   NumberOfStudents = {AskLoop University 0}
   {Wait R} % We can remove this if we want the function to be non-blocking
   R 
end

% TEST
{Browse {CharlotteAsync {CreateUniversityAsync 7}}}


