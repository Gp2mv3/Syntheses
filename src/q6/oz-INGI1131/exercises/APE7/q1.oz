declare
fun lazy {Ints N} N|{Ints N+1} end
fun lazy {Sum2 Xs Ys}
   case Xs#Ys of (X|Xr)#(Y|Yr) then (X+Y)|{Sum2 Xr Yr} end
end
S=0|{Sum2 S {Ints 1}}

% S=0|0+1=1|1+2=3|...
% I will display 3
{Browse S.2.2.1}

% We can see that
% 1) s_0 = 0
% 2) s_n = s_{n-1} + n
% Therefore
% s_n = 1 + 2 + ... + n = (n * (n+1)) / 2

% Kernel language
declare
proc {Ints N ?Y}
   thread
      local
         Z
         Inc
      in
         {WaitNeeded Y}
         Y = N|Z
         Inc = N + 1
         Z = {Ints Inc}
      end
   end
end
proc {Sum2 Xs Ys ?R}
   case Xs#Ys
   of (X|Xr)#(Y|Yr) then
      local
         Z
         Sum
      in
         Sum = X + Y
         R = Sum|Z
         Z = {Sum2 Xr Yr}
      end
   end
end
S=0|{Sum2 S {Ints 1}}
{Browse S.2.2.1}
