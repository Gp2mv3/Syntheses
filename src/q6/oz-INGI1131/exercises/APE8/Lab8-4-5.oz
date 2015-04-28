declare

% Le comportement de ce programme n'est pas deterministe
% puisque l'ordre dans lequel les messages seront envoyes depend
% de la valeur que prendra le Delay qui est choisie aleatoirement entre
% 1 et 3 secondes. En lancant plusieurs fois le programme,
% il y a bien un non-determinisme observable.
proc {ReadList Xs}
   case Xs
   of nil then skip
   [] X|Xr then {Browse X} {ReadList Xr}
   end
end

proc {RandomSenderManiac P N}
   proc {Loop I}
      if I>N then skip
      else
	 thread
	    {Delay {OS.rand} mod 3000 + 1000}
	    {Send P I}
	 end
	 {Loop I+1}
      end
   end
in
   {Loop 1}
end

fun {BrowserPort}
   Sin in
   thread {ReadList Sin} end
   {NewPort Sin}
end

P = {BrowserPort}
{RandomSenderManiac P 5}



