local Stack Result in
   Stack={NewStack}
   Result={NewStack}
   for I in {Length L}..1;~1 do
      {Push Stack {Nth L I}}
   end
   for while:{Not {IsEmpty Stack}} do
      local Elt in
	 Elt={Pop Stack}
	 case Elt of
	    '+' then {Push Result {Pop Result}+{Pop Result}}
	 [] '*' then {Push Result {Pop Result}*{Pop Result}}
	 [] '-' then {Push Result ~{Pop Result}+{Pop Result}}
	 [] '/' then
	    local X Y in
	       X={Pop Result}
	       Y={Pop Result}
	       {Push Result Y div X}
	    end
	 else {Push Result Elt} end
      end
   end
   {Pop Result}
end