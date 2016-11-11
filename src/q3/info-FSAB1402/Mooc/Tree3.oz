fun {FromTreeToList L}
   case T
   of btree(1:X left:L right:R) then {Append {Append {FromTreeToList L} [X]} {FromTreeToList R}}
   else nil
   end
end