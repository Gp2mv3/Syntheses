declare
fun {Fact N}
   fun {FactAux Precedent PrePrecedent N}
      if N==0 then nil
      elseif Precedent == 0 then 1|{FactAux 1 0 N-1}
      elseif PrePrecedent == 0 then 1|{FactAux 1 1 N-1}
      else
	 A
      in
	 A = Precedent+PrePrecedent
	 A|{FactAux A Precedent N-1}
      end
   end
in
   {FactAux 0 0 N}
end

{Browse {Fact 6}}   % affiche [1 2 6 24]