declare
proc {Max L Z}
   proc {MaxLoop L M R}
      case L of nil then R = M
      [] H|T then
	 if M > H then {MaxLoop T M R}
	 else {MaxLoop T H R} end
      end
   end
in
   if L == nil then Z = error
   else {MaxLoop L.2 L.1 Z} end
end

{Browse {Max [4 2 7 8 6]}}