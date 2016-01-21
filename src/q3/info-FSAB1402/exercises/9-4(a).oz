local Producer Filter Consumer S1 S2 in
   fun {Producer S} 
      local 
	 fun {ProducerAux Acc}
	    if S+1 > Acc then Acc|{ProducerAux Acc+1}
	    else nil end
	 end
      in
	 {ProducerAux 1}
      end
   end 

   fun {Filter S}
      case S of X|S2 then 
	 if (X mod 2) == 1 then X|{Filter S2}
	 else {Filter S2}
	 end
      else nil end
   end

   fun {Consumer S2}
      local 
	 fun {ConsumerAux S2 Sum}
	    case S2 of X|S3 then {ConsumerAux S3 Sum+X}
	    else Sum
	    end
	 end
      in 
	 {ConsumerAux S2 0}
      end
   end
   
   thread S1={Producer 20} end
   thread S2={Filter S1} end
   thread {Browse {Consumer S2}} end
   
end