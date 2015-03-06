declare
% The first one is correct and the second is not !
% Here is the second, where we have added Delay so that it is more visible
% NB: why are NewQueue1 and NewQueue2 fun and not proc ?
%     I added a return of C
fun {NewQueue2 ?Insert ?Delete}
   X C={NewCell q(0 X X)}
   L1={NewLock}
   L2={NewLock}
in
   proc {Insert X}
      N S E1 in
      lock L1 then
         q(N S X|E1)=@C
         {Delay 42} % Let Delete updates C so we erase it
         C:=q(N+1 S E1)
      end
   end
   proc {Delete ?X}
      N S1 E in
      lock L2 then
         {Delay 42} % So we are almost sure that the Insert begins
         q(N X|S1 E)=@C
         C:=q(N-1 S1 E)
      end
   end
   C
end

Insert Delete
Q = {NewQueue2 Insert Delete}
X1 X2
{Insert 1}
thread {Insert 2} X1 = unit end
thread {Delete _} X2 = unit end % it should delete 1
{Wait X1} {Wait X2}
% We get [1 2], the Delete a therefore been ignored !
{Browse [{Delete} {Delete}]}