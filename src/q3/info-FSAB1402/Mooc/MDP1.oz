fun {Eval Port}
   S P = {NewPort S}
   proc{Boucle S}
      for E in S do
	 case E of Function#Input
	 then {Send Port {Function Input}}
	 else skip end
      end
   end
in
   thread {Boucle S} end
   P
end