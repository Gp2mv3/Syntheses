fun {Calculate N}
   local CalcAux in
      fun {CalcAux N Acc}
	 case N of 0 then Acc
	 else {CalcAux N-1 Acc+Acc*Acc}
	 end
      end
      {CalcAux N 1}
   end
end