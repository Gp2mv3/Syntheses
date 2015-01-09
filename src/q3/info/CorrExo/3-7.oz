declare
fun {MultList L}
   fun {MultListAux L Acc}
      case L of nil then Acc
      []H|T then {MultListAux T Acc*H}
      end
   end
in
   {MultListAux L 1}
end

{Browse {MultList [1 2 3 4]}}   % affiche 24
