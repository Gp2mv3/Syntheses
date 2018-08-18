declare
fun {NewPortObject Behaviour Init}
   proc {MsgLoop S1 State}
      case S1
      of S1|S2 then
	 {MsgLoop S2 {Behaviour S1 State}}
      [] nil then skip
      end
   end
   Sin
in
   thread {MsgLoop Sin Init} end
   {NewPort Sin}
end

fun {DishWasher Size Timer}
   {NewPortObject
    fun {$ Msg State}
       case Msg
       of fill(N) then
	  case State
	  of (_#Q)|_ then
	     if Q == full then
		{Browse 'dishwasher full scuz frr'}
		State
	     elseif Q<Size then
		if Q == Size-1 then
		   {Browse 'dishwasher full mainan stop'}
		   (N#full)|State
		else
		   {Browse 'dishwasher elements : '#Q+1}
		   (N#(Q+1))|State
		end
	     end
	  else
	     {Browse 'dishwasher elements:'#1}
	     (N#1)|State
	  end
       [] clean() then
	  N
       in
	  {Send Timer clean(N)}
	  {Wait N}
	  nil
       else
	  {Browse wut}
	  State
       end
    end
    nil}
end
fun {Timer}
   {NewPortObject
    fun {$ Msg State}
       case Msg
       of clean(N) then
	  {Browse 'Dishwasher Cleaning'}
	  {Delay 5000}
	  {Browse 'Dishwasher cleaned'}
	  N = true
	  State
       end
    end
    random}
end
D T
T = {Timer}
D = {DishWasher 5 T}
{Send D fill(glass)}
{Send D fill(glass)}
{Send D fill(glass)}
{Send D fill(glass)}
{Send D fill(glass)}
{Send D clean()}
{Delay 6000}
{Send D fill(glass)}
{Send D fill(glass)}
{Send D fill(glass)}
{Send D fill(glass)}
{Send D fill(glass)}
{Send D fill(glass)}
