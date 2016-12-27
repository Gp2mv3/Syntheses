fun {Rabbit N}
   local Ouk in
      fun{Ouk A B C N}
	 if N == 3 then A + B + C
	 else
	    {Ouk B C A+B+C N-1}
	 end
      end
      if N == 0 then 2
      elseif N == 1 then 4
      elseif N == 2 then 8
      else
	 {Ouk 2 4 8 N}
      end
   end
end