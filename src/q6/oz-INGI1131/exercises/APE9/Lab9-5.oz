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

% This queue is quite inefficient because
% enqueue takes theta(n) where n is the queue's size
fun {NewQueue}
   fun {Transition Msg Queue}
      case Msg
      of enqueue(X) then {Append Queue [X]}
      [] dequeue(?X) then
         if Queue==nil then X=nil nil
         else X=Queue.1 Queue.2 end
      [] isEmpty(X) then X=(Queue==nil) Queue
      end
   end
in
   {NewPortObject Transition nil}
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


