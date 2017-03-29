local Nil Cons MMap ML1 ML2 N Fun T1 T2 T3 T4 M1 M2 M3 I1 I2 I3 in
   Nil = proc{$ R}
	    local Ni in
	       Ni = nil
	       {NewCell Ni R}
	    end
	 end
   
   Cons = proc{$ A B R}
	     local T in
		T = '|'(A B)
		{NewCell T R}
	     end
	  end
   MMap = proc{$ ML F R}
	     local T1 T2 T3 in
		T1 = @ML
		case T1
		of '|'(H MT) then
		   {F H T2}
		   {MMap MT F T3}
		   {Cons T2 T3 R}
		else 
		   {Nil R}
		end
	     end
	  end
   I1 = 6
   I2 = 5
   I3 = 4
   {Nil M1}
   {Cons I1 M1 M2}
   {Cons I2 M2 M3}
   {Cons I3 M3 ML1}
   N = 3
   Fun = proc{$ X R}
	    local T in
	       T = X * X
	       R = N*T
	    end
	 end
   {MMap ML1 Fun ML2}
   T1 =@ML2
   T2 = T1.2
   T3 = @T2
   T4 = T3.1
   {Browse T4}
end

		