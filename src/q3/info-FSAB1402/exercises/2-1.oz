declare
fun{Sum N}
   if N==0 then 0
   else N*N+{Sum N-1} end
end
{Browse {Sum 6}}

declare
fun{Sum2 N Acc}
   if N==0 then Acc
   else {Sum2 N-1 N*N+Acc} end
end
{Browse {Sum2 6 0}}