declare
fun {Add B1 B2}
   fun {AddDigits D1 D2 C1}
      Sum = D1+D2+C1
   in
      if Sum==0 then [0 0]
      elseif Sum==1 then [0 1]
      elseif Sum==2 then [1 0]
      elseif Sum==3 then [1 1]
      end
   end
   
   fun {AddAux L1 L2 C1 Acc}
      case L1#L2 of nil#nil then C1|Acc
      [](H1|T1)#(H2|T2) then
	 Sum = {AddDigits H1 H2 C1}
	 {Browse Sum}
      in
	 {AddAux T1 T2 Sum.1 Sum.2.1|Acc}
      end
   end
in
   {AddAux {Reverse B1} {Reverse B2} 0 nil}
end

{Browse {Add [1 1 0 1 1 0] [0 1 0 1 1 1]}}   % affiche [1 0 0 1 1 0 1]