local Remp R in
   proc{Remp A B R}
      if (A \=nil) then (R.(A.1) = {Transform B.1})
      end
      if (A \= nil andthen B \=nil) then {Remp A.2 B.2 R}
      end
   end
   case L
   of (H|T) then
      R = {Record.make L.1 L.2.1}
      {Remp L.2.1 L.2.2.1 R}
      R
   else
      L
   end
end