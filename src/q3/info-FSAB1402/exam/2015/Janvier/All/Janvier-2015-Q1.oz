declare
fun{Modes L}
   local
      fun{AuxModes L B}
	 case L of H|nil andthen B then H|nil
	 [] H1|H2|T andthen B then
	    if H1>H2 then H1|{AuxModes H2|T false}
	    elseif H2>H1 then {AuxModes H2|T true}
	    else {AuxModes H2|T false}
	    end
	 [] H1|H2|T then
	    if H2>H1 then {AuxModes H2|T true}
	    else {AuxModes H2|T false}
	    end
	 else
	    nil
	 end
	 
      end
   in
      {AuxModes L true}
   end
end
{Browse {Modes [1 1 69 1 1]}}
{Browse {Modes [1 2 1 40 5 6]}}

fun{ModesFixe L}
   if{Length L}=<1 then L
   else {ModesFixe {Modes L}}
   end
end
{Browse {ModesFixe [1 2 1 5 1 2]}}