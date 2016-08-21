declare
fun {Reverse List}
   fun {ReverseIter List Acc}
      case List of nil then Acc
      []  H|T then {ReverseIter T H|Acc}
      end
   end
in
   {ReverseIter List nil}
end

declare
fun{FoldZ F L V}
   case L
   of H|T then {FoldZ F {Reverse T} {F H V}}
   else V
   end
end

declare
fun{TestFold L}
    {FoldZ  fun{$ X Y}  X|Y end L  nil}
end

{Browse {TestFold [1 2 3 4 5 6 7 8 9]}}