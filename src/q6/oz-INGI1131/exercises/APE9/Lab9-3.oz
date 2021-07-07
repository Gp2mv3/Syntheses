% Author: Francois Robinet
declare

% This is the same as the GenericServerWithAcc
% from TP8 except the loop is a procedure
% so the final state isn't returned
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

fun {Porter}
   fun {Transition Msg People}
      case Msg
      of getIn(N) then People+N
      [] getOut(N) then R=People-N in
         if R<0 then raise emptyRoomException(People) end 
         else R end
      [] getCount(N) then N=People People
      else raise invalidMessage(Msg) end
      end
   end
in
   {NewPortObject Transition 0}
end

% Tests
P = {Porter}
{Browse {Send P getCount($)}} % should be 0
{Send P getIn(3)}
{Browse {Send P getCount($)}} % should be 3
{Send P getOut(2)}
{Browse {Send P getCount($)}} % should be 1

% {Send P getOut(2)} % Should raise an exception



