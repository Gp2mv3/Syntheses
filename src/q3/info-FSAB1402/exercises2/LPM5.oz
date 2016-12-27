fun {FlattenList L}
   case L of H|T then {Append {FlattenList H} {FlattenList T}}
   [] nil then nil
   else [L]
   end
end