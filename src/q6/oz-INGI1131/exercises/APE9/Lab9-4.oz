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

fun {NewStack}
   fun {Transition Msg Stack}
      case Msg
      of push(X) then X|Stack
      [] pop(?X) then
         if Stack==nil then X=nil Stack
         else X=Stack.1 Stack.2 end
      [] isEmpty(X) then X=(Stack==nil) Stack
      end
   end
in
   {NewPortObject Transition nil}
end

proc {Push S X}
   {Send S push(X)}
end

fun {Pop S}
   X in
   {Send S pop(X)}
   {Wait X} % We wait here because we don't want Pop to return without binding X
   X
end

fun {IsEmpty S}
   X
in
   {Send S isEmpty(X)}
   {Wait X}
   X
end

% Tests
S={NewStack}
{Push S a}
{Push S b}
{Browse {Pop S}} % b
{Browse {IsEmpty S}} % false
{Browse {Pop S}} % a
{Browse {Pop S}} % nil
{Browse {IsEmpty S}} % true