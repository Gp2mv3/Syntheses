declare NewStack S Temp1 Temp2 A B C in
NewStack = proc{$ R}
	      local C Push Pop IsEmpty A in
		 A = nil
		 {NewCell A C}
		 Push = proc{$ X}
			   local Temp1 Temp2 in
			      Temp1 = @C
			      Temp2 = X|Temp1
			      C := Temp2
			   end
			end
		 Pop = proc{$ X}
			  local S in
			     S = @C
			     X = S.1
			     C := S.2
			  end
		       end
		 IsEmpty = proc{$ B}
			      local Temp1 Temp2 in
				 Temp1 = @C
				 Temp2 = nil
				 B = Temp1 == Temp2
			      end
			   end
		 R = stack(push:Push pop:Pop isempty:IsEmpty)
	      end
	   end
{NewStack S}
Temp1 = S.push
{Temp1 a}
{Temp1 b}
Temp2 = S.pop
{Temp2 A}
{Browse A}
{Temp2 B}
{Browse B}
{Temp2 C}
{Browse C}