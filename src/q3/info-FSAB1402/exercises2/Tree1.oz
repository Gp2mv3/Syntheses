if Tree == leaf then nil
elseif Tree.left \= leaf then
   if Tree.right \= leaf then
      {Append {Append {Infix Tree.left} [Tree.1]} {Infix Tree.right}}
   else {Append {Infix Tree.left} [Tree.1]}
   end
elseif Tree.right \=leaf then
   {Append [Tree.1] {Infix Tree.right}}
else [Tree.1]
end