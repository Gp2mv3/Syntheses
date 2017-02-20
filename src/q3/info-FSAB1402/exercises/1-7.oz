{Browse {Max 3 7}}
{Browse {Not 3==7}}

% a
declare
X=7
Y=5
Z=6
{Browse {Max X {Max Y Z}}}

% b
declare
fun {SlowAdd X Y}
    {Delay 1000} X+Y
end
local
   X
   in X={SlowAdd 1000 1}
   {Browse X*3}
end

% c
declare
fun {Signe N}
    if N==0 then 0 elseif N>0 then 1 else ~1 end
end

{Browse {Signe~5}}
{Browse {Signe 0}}
{Browse {Signe 10}}