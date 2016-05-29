%Exo 4
declare
fun {MergeSort L}
   L1 L2
in
   case L
   of nil then nil
   [] [X] then [X]
   else
      {Split L L1 L2}
      {Merge1 thread {MergeSort L1} end
       thread {MergeSort L2} end} 
   end
end

declare
proc {Split L L1 L2}
   case L of (H1|H2|T) then T1 T2 in
      L1= H1|T1
      L2= H2|T2
      {Split T T1 T2}
   [] H|nil then L1=[H] L2=nil
   [] nil then L1=nil L2=nil
   end
end

declare
fun{Merge1 S1 S2}
   case S1|S2 of
      (H1|T1)|(H2|T2) then
      if H1>H2 then
	 H2|{Merge1 S1 T2}
      elseif H1<H2 then
	 H1|{Merge1 T1 S2}
      else
	 H1|{Merge1 T1 S2}
      end
   [] S1|nil then S1
   [] nil|S2 then S2
   [] nil|nil then nil
   end
end

{Browse {MergeSort [2 8 7 9 5 3]}}
%1+2+4+...+n = somme pour i allant de 0 a log (n) = 2.N -1 car n+n/2 +n/4 ... tend vers 2n
