declare

% Similar to WaitTwo from Q5
% 1. Send the message#Acknowledgement to port P
% 2. Setup 2 threads: one will wait for the reply from P,
% the other will wait for T. Both will send a message to
% the internal port.
% 3. Create an internal port for the threads to send to.
% 4. Wait for the first message on the internal port and
% return it. Only the first message is important.
fun {SafeSend P M T}
   Ack InternalPort In in
   {Send P M#Ack} % 1

   % 2
   thread {Delay T} {Send InternalPort false} end
   thread case Ack of unit then {Send InternalPort true} end end

   InternalPort = {NewPort In} % 3
   In.1 % 4
end

%%%%%  Tests %%%%%

% Same as in Q7
fun {GenericServer P}
   In in
   thread for Msg in In do {P Msg} end end
   {NewPort In}
end

% This just waits 3 seconds before binding Ack
proc {ServerTask Msg}
   case Msg
   of _#?Ack then {Delay 3000} Ack=unit
   end
end

Server = {GenericServer ServerTask}

% Sends 'hi server!' to server
% waiting 1 second for the reply
% Since the server waits 3 seconds before replying,
% this should print false after about 1 second
thread {Browse {SafeSend Server 'hi server!' 1000}} end

% this time, waits 20 seconds, this should print true
% This should print true when the server replies after about 3 seconds
thread {Browse {SafeSend Server 'hi server!' 20000}} end
