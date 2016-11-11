local
   fun {Prems N Dec}
      if Dec >= N then true
      elseif (N mod Dec) == 0 then false
      else {Prems N (Dec+1)}
      end
   end
in
   if N =< 1 then false
   else
      {Prems N 2}
   end
end