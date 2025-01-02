%a
local Fib in
   fun{Fib N}
      if N<2 then 1
      else {Fib N-1}+{Fib N-2}
      end
   end
end

%b
declare
fun {FibAcc N}
   if N<2 then 1
   else
      local
         fun {FibAccIn N Acc1 Acc2}
            if N<3 then Acc2+Acc1
            else {FibAccIn N-1 Acc2 Acc1+Acc2}
            end
         end
      in
         {FibAccIn N 1 1}
      end
   end
end
for X in 0..5 do
   {Browse {FibAcc X}}
end
