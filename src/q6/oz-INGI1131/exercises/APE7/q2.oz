% Combinational logic:
% Logic circuits that have no internal memory.
% Their outputs are boolean functions of their inputs,
% and they are totally dependent on the inputs.

% Sequential logic:
% Circuits whose behavior depends on their own past input

declare
fun {NotG Xs}
   fun {Loop Xs}
      X|Xr=Xs
   in
      (1 - X)|{Loop Xr}
   end
in
   thread {Loop Xs} end
end

fun {DelayG Xs}
   0|Xs
end

fun {Oscillator}
   X Y
in
   Y = {DelayG X}
   X = {NotG Y}
   X
end

{Browse {Oscillator}}

% Bonus, the stream will just be O|_ until we need the rest
