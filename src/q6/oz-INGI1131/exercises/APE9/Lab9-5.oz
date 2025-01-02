% Author: Francois Robinet improved by Gauthier de Moffarts
declare

fun {NewPortObject Transition Init}
   proc {MsgLoop In State}
      case In
      of nil then skip
      [] Msg|Inr then
	 {MsgLoop Inr {Transition Msg State}}
      end
   end
   In
in
   thread {MsgLoop In Init} end
   {Port.new In}
end

%          A | B | C | D | E | _
% old back '   |   |       |   ' cur front
% cur back     '   |       '  old front
% next back        '
fun {NewQueue}
   fun {Transition Msg Queue}
      Queue = Front#Back#Num
   in
      case Msg
      of enqueue(X) then NewFront in
         Front=X|NewFront
         NewFront#Back#(Num+1)
      [] dequeue(?X) then
         if Num==0 then X=nil Queue % In an ideal world we could just do Front==Back but this will block
         else X=Back.1 Front#(Back.2)#(Num-1)
      [] isEmpty(X) then X=(Num==0) Queue
      end
   end
   Init
in
   {NewPortObject Transition Init#Init#0}
end

proc {Enqueue Q X}
   {Send Q enqueue(X)}
end
fun {Dequeue Q}
   X in
   {Send Q dequeue(X)}
   {Wait X}
   X
end
fun {IsEmpty Q}
   X
in
   {Send Q isEmpty(X)}
   {Wait X}
   X
end

% Tests
Q={NewQueue}
{Browse {IsEmpty Q}}% true
{Enqueue Q a}
{Browse {IsEmpty Q}}% false
{Enqueue Q b}
{Browse {Dequeue Q}} % a
{Browse {Dequeue Q}} % b
{Browse {Dequeue Q}} % nil
{Browse {IsEmpty Q}}% true


