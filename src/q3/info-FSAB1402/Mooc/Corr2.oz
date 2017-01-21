proc {Add N R}
   if N == 0 then R = 0
   else N + {Add N - 1}
   end
end