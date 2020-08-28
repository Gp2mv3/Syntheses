declare
%7
fun {Filter L F}
  if L==nil then nil
  elseif {F L.1} then L.1|{Filter L.2 F}
  else {Filter L.2 F}
  end 
end

%8
fun {IsEven A}
  A mod 2 == 0
end

{Browse {Filter [1 2 3 4 6 7] IsEven}}

%9
