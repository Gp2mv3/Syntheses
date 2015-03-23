declare

% Returns the port of a one-port server.
% The server applies the procedure P to each message received
% on its port.
fun {GenericServer P}
   Sin in
   thread
      proc {Loop Xs}
	 case Xs
	 of Msg|Xr then {P Msg} {Loop Xr}
	 end
      end
   in
      {Loop Sin}
   end
   {NewPort Sin}
end

% Task from the exercise
proc {ServerTask Msg}
   case Msg
   of M#?Ack then
      {Browse 'Server received message '#M}
      {Delay {OS.rand} mod 1500 + 500}
      Ack=unit
   end
end

% Sends a message to server then returns immediately
% Browses a message when the acknowledgement comes back from the server.
proc {Client Server}
   Ack in
   {Send Server '#'('hi server!' Ack)}
   thread {Wait Ack} {Browse 'Client received Acknowledgement from server'} end
end

% Test
{Client {GenericServer ServerTask}}
