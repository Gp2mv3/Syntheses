declare
fun{FlattenList L}
   fun{Append Xs Ys}
      case Xs
      of nil then Ys
      [] H|T then H|{Append T Ys} 
      end
   end
in  
   case L 
   of nil then nil
   [] H|T then {Append {FlattenList H} {FlattenList T}}
   else [L]
   end
end

{Browse {Flatten [a [b [c d]] e [[[f]]]]}}   % affiche [a b c d e f]

