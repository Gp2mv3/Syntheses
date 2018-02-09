fun {AndG X Y}
   case X#Y of (H|T)#(I|V)
   then H*I|{AndG T V}
   [] nil#nil then nil
   else X*Y
   end
end
fun {OrG X Y}
   case X#Y of (H|T)#(I|V)
   then H+I-(H*I)|{OrG T V}
   [] nil#nil then nil
   else X+Y-(X*Y)
   end
end
fun {XorG X Y}
   case X#Y of (H|T)#(I|V)
   then H+I-2*H*I|{OrG T V}
   [] nil#nil then nil
   else X+Y-2*Y*X
   end
end
proc{FullAdder X Y Z C S} A B D E F in
   A = {AndG X Y}
   B = {AndG Y Z}
   D = {AndG X Z}
   F = {OrG B D}
   C = {OrG A F}
   E = {XorG X Y}
   S = {XorG Z E}
end
fun{NFullAdder S1 S2}
   fun{Retourne L Acc}
      case L of H|T then {Retourne T H|Acc}
      else Acc
      end
   end
   proc{Add A B R Acc Liste Reste}
      case A#B of (H|T)#(I|V) then
	 C S in
	 {FullAdder H I R C S}
	 case T#V of nil#nil then
	    Liste = S|Acc
	    Reste = C
	 else
	    {Add T V C S|Acc Liste Reste}
	 end
      end
   end
in
   case S1#S2 of (H1|T1)#(H2|T2) then
      A = {Retourne H1 nil} 
      B = {Retourne H2 nil}
      Liste Reste
   in
      {Add A B 0 nil Liste Reste}
	 Liste#Reste|{NFullAdder T1 T2}
   else nil
   end
end
SA SB S5 S6 SC
S1 = [1 1 1 1 1]|[0 0 0 0 0]|[1 1 1 1 0]|S5
S2 = [1 1 1 1 1]|[0 0 0 0 0]|[0 0 0 0 1]|S6
thread SA=S1 end
thread SB=S2 end
thread SC = {NFullAdder SA SB} end
thread {Browse SC} end
