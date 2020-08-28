%a
define
fun {ForAllTail Xs P}
   case Xs of nil then skip
   [] H|T then
      {P Xs}
      {ForAllTail T P}
end

%b
fun {GetElementsInOrder Tree}
  if Tree.left == nil && Tree.right == nil then [Tree.info] 
  elseif Tree.left == nil then Tree.info|{GetElementsInOrder Tree.right} 
  elseif Tree.right == nil then Append{{GetElementsInOrder Tree.left} [Tree.info]}
  else Append{Append{{GetElementsInOrder Tree.left} [Tree.info]} {GetElementsInOrder Tree.right}
  end
end

%(plus court)
fun {GetElementsInOrder Tree}
  fun{Loop T Li}
      case T
      of nil then Li
      [] tree(info:I left:L right:R) then   
          {Loop R {Append {Loop L Li} [I]}}
      end
  end
in
  {Loop Tree nil}
end

Tree = tree(info:10 left:tree(info:7 left:nil right:tree(info:9 left:nil right:nil)) right:tree(info:18 left:tree(info:14 left:nil right:nil) right:nil))
{Browse {GetElementsInOrder Tree}} %-> [7 9 10 14 18]