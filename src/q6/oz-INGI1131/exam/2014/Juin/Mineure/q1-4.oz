proc {Touch C N}
   if N > 0 then
      {Touch C.2 N-1}
   end
end

% Tests
A B C
{Circuit A B C}
{Browse C}
{Touch C 10}
