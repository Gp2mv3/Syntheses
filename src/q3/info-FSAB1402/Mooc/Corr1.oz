fun {Add N}
   if N == 0 then 0
   else N+{Add N-1}
   end
end