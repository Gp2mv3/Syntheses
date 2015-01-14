declare
fun {Fact N}
   fun {FactAux Prev M}
      if M > N then nil
      else
	 A=Prev*M
      in
	 A|{FactAux A M+1}
      end
   end
in
   {FactAux 1 1}
end

{Browse {Fact 4}}   % affiche [1 2 6 24]