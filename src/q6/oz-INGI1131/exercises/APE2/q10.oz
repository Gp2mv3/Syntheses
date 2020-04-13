declare
fun {Flatten List}
  case List
  of nil then nil
  [] H|T then {Append {Flatten H} {Flatten T}}
  else [List]    
  end
end

{Browse {Flatten [a [b [c d]] e [[[f]]]]}} % -> [a b c d e f]