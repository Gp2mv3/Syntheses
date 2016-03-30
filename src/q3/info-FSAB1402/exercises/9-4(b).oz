local Barman SmellTrappist Consumer S1 S2 in
   fun {Barman N} 
      local 
	 fun {ServeBeer}
	    if {OS.rand} mod 2 == 1 then trappiste
	    else
	       pils
	    end
	 end
	 fun {BarmanAux Nb}
	    if Nb < N then {ServeBeer}| thread {Delay 3000} {BarmanAux Nb+1} end
	    else nil end
	 end
      in
	 {BarmanAux 0}
      end
   end 

   fun {SmellTrappist Beer}
      case Beer of X|S2 then 
	 if X == trappiste then true|{SmellTrappist S2}
	 else false|{SmellTrappist S2}
	 end
      else nil end
   end

   proc {Consumer S2 ?Charlotte ?GlouGlou}
      local 
	 proc {ConsumerAux S2 Acc1 Acc2}
	    case S2 of true|S3 then {ConsumerAux S3 Acc1+1 Acc2}
	    [] false|S3 then {ConsumerAux S3 Acc1 Acc2+1}
	    else
	       Charlotte=Acc1 GlouGlou=Acc2
	    end
	 end
      in 
	 {ConsumerAux S2 0 0}
      end
   end
   
   thread S1={Barman 20} end
   thread S2={SmellTrappist S1} end
   thread {Browse S1} end
   thread {Browse S2} end
   thread  local Charlotte GlouGlou
	   in
	      {Consumer S2 Charlotte GlouGlou}
	      {Browse Charlotte}
	      {Browse GlouGlou}
	   end
   end  
end