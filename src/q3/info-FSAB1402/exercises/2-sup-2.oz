% a
declare
fun {Numero X Y}
   fun{FunAux X Y Acc}
      if X+Y==0 then Acc
      elseif Y==0 then {FunAux 0 X-1  Acc+1 }
      else {FunAux X+1 Y-1  Acc+1 } end
   end
in
   {FunAux X Y 0}
end

{Browse {Numero 3 1}}

% b
declare
fun {Numero2 X Y}
   fun{NumTri N}
      (N*(N+1) div 2)%somme serie arithmetique
   end
in
   {NumTri X+Y}+Y
end

{Browse {Numero2 0 4}}

% c
declare
fun{CoordX N} Pt Lg
   proc{Ligne L Lig Pt}
      if (N-(L*(L+1) div 2))=<L then Lig=L Pt=(L*(L+1) div 2)
      else {Ligne L+1 Lig Pt} end
   end
in
   {Ligne 0 Lg Pt}
   Lg-(N-Pt)
end
{Browse {CoordX 8}}

declare
fun{CoordY N} Pt
   proc{Ligne L Pt}
      if (N-(L*(L+1) div 2))=<L then Pt=(L*(L+1) div 2)
      else {Ligne L+1 Pt} end
   end
in
   {Ligne 0 Pt}
   N-Pt
end

{Browse {CoordY 8}}