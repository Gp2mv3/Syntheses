declare
proc {Count N}
   local
      proc {CountFrom I}
	 if I=<N then {Browse I} {CountFrom I+1} end
      end
   in
      {CountFrom 1}
   end
end

{Count 3}