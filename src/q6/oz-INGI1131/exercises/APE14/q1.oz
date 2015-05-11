declare
% Monitor
fun {NewQueue}
   X
   Q = {NewCell q(0 X X)}
   L = {NewLock}
   proc {Insert X}
      N M S E
   in
      lock L then
         {Exchange Q q(N S X|E) q(M S E)}
      end
      M = N+1
   end
   proc {Delete ?X}
      N M S E
   in
      lock L then
         {Exchange Q q(N X|S E) q(M S E)}
         M = N-1
      end
   end
   fun {DeleteNonBlock}
      N
   in
      lock L then
         q(N _ _) = @Q
         if N > 0 then
            [{Delete}]
         else
            nil
         end
      end
   end
   proc {DeleteAll ?S}
      E X
   in
      lock L then
         {Exchange Q q(_ S E) q(0 X X)}
         E = nil
      end
   end
in
   queue(insert:Insert deleteAll:DeleteAll deleteNonBlock:DeleteNonBlock)
end
fun {NewReleaseLock}
   C = {NewCell unit}
   Next = {NewCell unit}
   CurThread = {NewCell unit}
   fun {GetLock}
      if @CurThread \= {Thread.this} then
         Old New
      in
         {Exchange C Old New}
         {Wait Old}
         CurThread := {Thread.this}
         Next := New
         true
      else
         false
      end
   end
   proc {ReleaseLock}
      CurThread := unit
      @Next = unit
   end
in
   rlock(get:GetLock release:ReleaseLock)
end
fun {NewMonitor}
   L = {NewReleaseLock}
   Q = {NewQueue}
   proc {LockM P}
      if {L.get} then
         try {P} finally {L.release} end
      else {P} end
   end
   proc {WaitM}
      X
   in
      {Q.insert X}
      {L.release}
      {Wait X}
      if {L.get} then skip end
   end
   proc {NotifyM}
      X = {Q.deleteNonBlock}
   in
      X = unit
   end
   proc {NotifyAllM}
      L = {Q.deleteAll}
   in
      for X in L do
         X = unit
      end
   end
in
   monitor('lock':LockM wait:WaitM notify:NotifyM notifyAll:NotifyAllM)
end

% Question 1
proc {MakeMvar ?Put ?Get}
   M = {NewMonitor}
   Set = {NewCell false}
   Val = {NewCell 0} % The value doesn't matter since @Set == false
in
   proc {Put X}
      {M.'lock'
       proc {$}
          if @Set then {M.wait} {Put X}
          else Val := X Set := true {M.notifyAll} end
       end}
   end
   proc {Get ?X}
      {M.'lock'
       proc {$}
          if {Not @Set} then {M.wait} {Get X}
          else X = @Val Set := false {M.notifyAll} end
       end}
   end
end
class MakeMvar2
   attr m set val
   meth init
      m := {NewMonitor}
      set := {NewCell false}
      val := {NewCell 0} % The value doesn't matter since @@set == false
   end
   meth put(X)
      {@m.'lock'
       proc {$}
          if @@set then {@m.wait} {self put(X)}
          else @val := X @set := true {@m.notifyAll} end
       end}
   end
   meth get(?X)
      {@m.'lock'
       proc {$}
          if {Not @@set} then {@m.wait} {self get(X)}
          else X = @@val @set := false {@m.notifyAll} end
       end}
   end
end

Put Get X
{MakeMvar Put Get}
thread {Get X} end
thread {Put 1} {Put 2} end
% Displays 1
{Browse X}

Y
Mvar2 = {New MakeMvar2 init}
thread {Mvar2 get(Y)} end
thread {Mvar2 put(1)} {Mvar2 put(2)} end
% Displays 1
{Browse Y}
