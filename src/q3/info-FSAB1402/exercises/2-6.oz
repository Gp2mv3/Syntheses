declare
fun {Fib2 N}
   if N==0 then 0
   elseif N==1 then 1
   else {Fib2 N-1}+{Fib2 N-2} end
end