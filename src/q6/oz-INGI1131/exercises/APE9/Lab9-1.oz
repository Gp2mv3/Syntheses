% Author: Francois Robinet
declare

% Generic server without internal state (no accumulator)
% See lab 8
% In this version, we also have to put each call to P in its own thread
% Because the msg aren't independant, so treating a message
% can block the server: if message M1 needs a variable
% that's bound by message M2, then executing {P M1} before {P M2}
% in the server's thread will deadlock.
% This isn't necessary if every Msg are independant.
fun {GenericServer P}
   In in
   thread for Msg in In do thread {P Msg} end end end
   {Port.new In}
end

fun {LaunchServer}
   {GenericServer
    proc{$ Msg}
       case Msg
       of add(X Y R) then R=X+Y
       [] pow(X Y R) then R={Number.pow X Y}
       [] 'div'(X Y R) then try R=(X div Y) catch _ then R=divisionByZero(x:X y:Y) end
       else {Show 'message not understood'}
       end
    end}
end

%%% TEST %%%
% We're using Asynchronous RMI protocol
% with server-side threads. For every message
% a new thread is created on the server.
A B N S
Res1 Res2 Res3 Res4 Res5 Res6
S = {LaunchServer}
{Send S add(321 345 Res1)}
{Wait Res1} {Show res1(Res1)}

{Send S pow(2 N Res2)}
N=8
{Wait Res2} {Show res2(Res2)}

{Send S add(A B Res3)} % Server will wait for A and B
{Send S add(10 20 Res4)} % Server binds res4 immediately
{Send S foo} % Server show this is invalid in the emu
{Wait Res4} {Show res4(Res4)}

A=3
B = ~A % Now Server can bind Res3=A+B=0

% Will wait for Res3 then attempt a division by 0,
% and bind Res5 to an record explaining the problem
{Send S 'div'(90 Res3 Res5)}

{Send S 'div'(90 Res4 Res6)} % Will wait for Res4
{Wait Res3} {Show res3(Res3)}
{Wait Res5} {Show res5(Res5)}
{Wait Res6} {Show res6(Res6)}


