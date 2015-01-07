declare
fun {Append L1 L2}
   case L1 of nil then L2
   []H|T then H|{Append T L2}
   end
end

{Browse {Append [r a] [p h]}}       % affiche [r a p h]
{Browse {Append [b [o r]] [i s]}}   % affiche [b [o r] i s]
{Browse {Append nil [l u i s]}}     % affiche [l u i s]