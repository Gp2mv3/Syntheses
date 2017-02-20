% a 
declare
fun {NombrePavages N}
   fun{NbDiv Num Acc}
      if Num==0 then Acc
      elseif (N mod Num)==0  then {NbDiv Num-1 Acc+1}
      else {NbDiv Num-1 Acc}
      end	 
   end
in
   {NbDiv N 0}
end

{Browse{NombrePavages 6}}

% b
declare
fun {NombrePaves N}
   fun{NbDiv Num Acc}
      if Num==0 then Acc
      elseif (N mod Num)==0  then {NbDiv Num-1 Acc+Num*Num}
      else {NbDiv Num-1 Acc}
      end	 
   end
in
   {NbDiv N 0}
end

{Browse{NombrePaves 6}}