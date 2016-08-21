declare
local
   proc {CountFrom I N}
      if I=<N then {Browse I} {CountFrom I+1 N} end
   end
in
   proc {Count N}
      {CountFrom 1 N}
   end
   {Count 4}
end