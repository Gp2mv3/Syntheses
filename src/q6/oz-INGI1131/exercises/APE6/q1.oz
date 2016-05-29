%Exo 1

declare
fun lazy {Gen I}
   I|{Gen I+1}
end

local X Y in
   X = {Gen 100}
   Y=X.2.2.1
   {Browse X}
end

declare
proc {Touch L N}
   if N==0 then skip
   else {Touch L.2 N-1}
   end
end

declare
fun {GiveMeNth N L}
   if N==0 then L.1
   else {GiveMeNth N-1 L.2}
   end
end

local X in
   X = {Gen 100}
   {Browse {GiveMeNth 25 X}}
end