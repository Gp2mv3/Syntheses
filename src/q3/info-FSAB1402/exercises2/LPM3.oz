proc {TestPattern L}
  case L
  of M then {Browse 1}
  [] H|T then {Browse 2}
  [] nil then {Browse 3}
  end
end