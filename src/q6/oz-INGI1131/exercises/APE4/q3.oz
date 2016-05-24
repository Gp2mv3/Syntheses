%Exo 3
proc {PassingTheToken Id Tin Tout}
   case Tin of H|T then X in
      {Show Id#H}
      {Delay 1000}
      Tout = H|X
      {PassingTheToken Id T X}
   [] nil then
      skip
   end
end

local X Y Z in
   thread {PassingTheToken 1 X Y} end
   thread {PassingTheToken 2 Y Z} end
   thread {PassingTheToken 3 Z X} end
end