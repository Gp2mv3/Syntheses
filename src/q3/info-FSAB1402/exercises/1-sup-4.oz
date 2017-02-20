% a
declare
fun{MonMax1 X Y}
   if X>Y then X else Y end
end
declare
fun{MonMax2 X Y}
   {Max X Y}
end

% b
declare %%double declaration du Y
X=1 Y=2
Y={MonMax1 X Y}
{Browse Y}

declare %%double declaration du Y
X=2 Y=1
Y={MonMax1 X Y}
{Browse Y}

declare
X=2 Y=1
{Browse Y=={MonMax1 X Y}}

% c
declare
fun{MonMax3 Z}
   {Max X Z}
end

% d
declare
X=1 Y=2
{Browse {MonMax3 Y}}

declare
X=1 Y=2
{Browse {MonMax3 X}}