declare

% Waits for X or Y to be bound
% NB: The operations are not atomic so it's possible
% that the function returns 2 (for Y) even if X was bound first,
% if Y was also bound at the time of the call. This means
% WaitTwo cannot be used to know which of X or Y was bound first,
% but only to know at least one is bound, and which one it is!
fun {WaitTwo X Y}
   P Sin in
   % Threads waiting on X/Y
   thread {Wait X} {Send P x} end
   thread {Wait Y} {Send P y} end

   % Port to send the messages to
   P = {NewPort Sin}

   % Deals with the first message
   % The second message sent to port
   % is ignored since we only care about the first one
   case Sin
   of x|_ then 1
   [] y|_ then 2
   end
end

X Y R

% Waits for X or Y to be bound
% and prints the result of WaitTwo
thread  {Browse {WaitTwo X Y}} end

% Binds X and Y after a random delay of 1 to 3 seconds
% the above thread browse 1 or 2 depending on which WaitTwo sees as bound first.
thread {Delay {OS.rand} mod 3000 + 1000} X=5 end
thread {Delay {OS.rand} mod 3000 + 1000} Y=7 end
