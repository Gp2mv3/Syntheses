%Exo 1a
local X Y Z in
   thread if X==1 then Y=2 else Z=2 end end
   thread if Y==1 then X=1 else Z=2 end end
   X=1
   {Browse X|Y|Z}
end

%X=1 Y=2 Z=2

%Exo1b
local X Y Z in
   thread if X==1 then Y=2 else Z=2 end end
   thread if Y==1 then X=1 else Z=2 end end
   X=2
   {Browse X|Y|Z}
end

% X=2 Z=2 Y=_
