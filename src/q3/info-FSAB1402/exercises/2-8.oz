declare
proc{CountDown N}
   if N=<0 then {Browse 0}
   else
      {Browse N}
      {CountDown N-1}
   end
end   

{CountDown 3}