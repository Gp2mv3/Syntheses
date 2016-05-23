%Exo 8
declare
proc {Ping L}
   case L of H|T then T2 in
      {Delay 500} {Browse ping}
      T= |T2
      {Ping T2}
   end
end
declare
proc {Pong L}
   case L of H|T then T2 in
      {Browse pong}
      T= |T2
      {Pong T2}
   end
end

declare L in
thread {Ping L}end
thread {Pong L.2}end
L=_|_
