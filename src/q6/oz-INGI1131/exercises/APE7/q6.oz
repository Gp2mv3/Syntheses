declare
fun {Counter InS}
   fun {ListAdd L E}
      case L
      of nil then [E#1]
      [] H|T then
         if H.1 == E then
            E#(H.2+1)|T
         else
            H|{ListAdd T E}
         end
      end
   end
   % We first take the first of the first pipe then the first of the second pipe ...
   % and then the second on the first pipe, second of the second pipe...
   % Cur contains the list of the pipes at their current state without the pipes that are ahead of the other ones
   % Next contains the list of the pipes at the next state (after we have taken their first element) for the pipes that are ahead of the other ones
   % NextEnd contains the end of Next (where we append the next pipes)
   % Acc contains the current value of the list with all the counters
   fun {Count Cur Next NextEnd Acc}
      case Cur of
         nil then % There is no more pipe, let's set Cur to Next and continue
         NextEnd = nil % We first end the list Next
         if Next == nil then % If next is nil, that means that ther is no pipe or that they have all finished
            nil              % so  we end the output and finish the recursion
         else Next2 in       % Else we create a new Next and replace Cur with Next
            {Count Next Next2 Next2 Acc}
         end
      [] InSi|InSr then % Let's split Cur between the first
         case InSi
         of nil then % This pipes finishes, let's not put it in Next so that it will be ignored for the rest of the recursion
            {Count InSr Next NextEnd Acc}
         [] H|T then Acc2 NextEnd2 in
            NextEnd = T|NextEnd2    % We add the rest of the pipe to Next
            Acc2 = {ListAdd Acc H}  % and update the counter
            Acc2|{Count InSr Next NextEnd2 Acc2}
         end
      end
   end
   Next
in
   thread {Count InS Next Next nil} end
end

local
   InS1 InS2 InS3
in
   {Browse {Counter [InS1 InS2 InS3]}}
   InS1=e|c|_
   InS2=m|_
   InS3=e|_
end

% If one stop with a nil, the Counter simply continues (thanks to our robust solution)
local
   InS1 InS2 InS3
in
   {Browse {Counter [InS1 InS2 InS3]}}
   InS1=e|c|nil
   InS2=m|nil
   InS3=e|m|e|c|nil
end

% If it just stop with an unbound variable, we are blocked
local
   InS1 InS2 InS3
in
   {Browse {Counter [InS1 InS2 InS3]}}
   InS1=e|c|nil
   InS2=m|_
   InS3=e|m|e|c|nil
end
