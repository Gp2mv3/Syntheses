declare
fun {Lisser K L}
   Leng={Length L}
   fun {DeleteBegin L N}
      if N==0 then L
      else
	 case L of nil then nil
	 []H|T then {DeleteBegin T N-1}
	 end
      end
   end
   
   fun {DeleteEnd L N}
      if N==0 then nil
      else
	 case L of nil then nil
	 []H|T then H|{DeleteEnd T N-1}
	 end
      end
   end

   fun {Proceed L}
      fun {Sum L Acc}
	 case L of nil then Acc
	 []H|T then {Sum T Acc+H}
	 end
      end
      fun{ProceedAux L}
	 case L of nil then nil
	 []H|T then ({Sum H 0.0}/{IntToFloat K})|{ProceedAux T}
	 end
      end
   in
      {ProceedAux L}
   end

   fun {CreateTempList N}
      if N>(Leng-K) then nil
      else {DeleteEnd {DeleteBegin L N} K}|{CreateTempList N+1}
      end
   end
in
   {Proceed {CreateTempList 0}}   
end

%{Browse {Lisser 3 [1.0 1.0 2.0 3.0 5.0 8.0]}}




declare
fun {LisserLarge K S L}
   Leng={Length L}
   fun {DeleteBegin L N}
      if N==0 then L
      else
	 case L of nil then nil
	 []H|T then {DeleteBegin T N-1}
	 end
      end
   end
   
   fun {DeleteEnd L N}
      if N==0 then nil
      else
	 case L of nil then nil
	 []H|T then H|{DeleteEnd T N-1}
	 end
      end
   end

   fun {Proceed L}
      fun {Sum L Acc}
	 case L of nil then Acc
	 []H|T then {Sum T Acc+H}
	 end
      end
      fun{ProceedAux L}
	 case L of nil then nil
	 []H|T then ({Sum H 0.0}/{IntToFloat K})|{ProceedAux T}
	 end
      end
   in
      {ProceedAux L}
   end

   fun {TakeElement L}
      fun {TakeElementAux L N}
	 case L of nil then nil
	 []H|T then
	    if N==0 then H|{TakeElementAux T S-1}
	    else {TakeElementAux T N-1}
	    end
	 end
      end
   in
      {TakeElementAux L 0}
   end
      
   fun {CreateTempList I}
      if I+(K-1)*S + 1 >Leng then nil
      else {TakeElement {DeleteEnd {DeleteBegin L I} I+(K-1)*S+1}}|{CreateTempList I+1}
      end
   end
in
   {Proceed {CreateTempList 0}}   
end

{Browse {LisserLarge 3 2 [1.0 1.0 2.0 3.0 5.0 8.0]}}
