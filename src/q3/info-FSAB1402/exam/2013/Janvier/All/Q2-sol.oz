local C MC in
   local Zero in
      Zero=0
      {NewCell Zero C}
   end
   MC=proc {$ E R1}
	 local D MC2 in
	    local One in
	       One=1
	       {NewCell One D}
	    end
	    MC2=proc {$ P C}
		   {P C}
		end
	    local V1 V2 V3 in
	       V1 = 1
	       V2 = @E
	       V3 = V1+V2
	       E := V3
	    end
	    local P1 in
	       P1=proc {$ D}
		     local W1 W2 W3 in
			W1 = 10
			W2 = @D
			W3 = W1+W2
			D := W3
		     end
		  end % proc P1
	       {MC2 P1 C}
	    end % local P1
	    R1 = @D
	 end % local D MC2
      end % proc MC
   local R2 in
      {MC C R2}
      {Browse R2}
   end
end
