%1) First program:
local Res in
   local Arg1 Arg2 in
      Arg1 = 7
      Arg2 = 6
      Res = Arg1 * Arg2
   end
   {Browse Res}
end

%2) Second program:
local Res in
   local Arg1 Arg2 in
      Arg1 = 7
      Res = Arg1 * Arg2
      Arg2 = 6
   end
   {Browse Res}
end