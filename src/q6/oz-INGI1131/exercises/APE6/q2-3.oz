%Exo 2
declare
fun lazy {LazyFilter Xs P}
   case Xs of
      nil then nil
   [] X|Xr then
      if {P X} then
	 X|{LazyFilter Xr P}
      else
	 {LazyFilter Xr P}
      end
   end
end
fun lazy {LazySieve Xs}
   case Xs of nil then nil
   [] X|Xr then
      X|{LazySieve {LazyFilter Xr fun {$ Y} Y mod X \= 0 end}}
   end
end
fun lazy {Primes}
   {LazySieve {Gen 2}}
end

%Exo 3
declare
fun {ShowPrimes N}
   L in
   L = {Primes}
   {Touch L N}
   L
end
proc {Touch L N}
   if N == 0 then skip
   else {Touch L.2 N-1}
   end
end
local X in
   thread X={ShowPrimes 10} end
   {Browse X}
end
%NB {Wait X} attend que X vaille qqch {WaitNeeded X} attend que X soit demande par une instruction.