%Exo 2a
declare
fun {Not X}
   if X==1 then 0
   else 1
   end
end
fun {NotGate X}
   {Not X.1}|{NotGate X.2}
end

%Exo 2b
declare
fun{AndGate X Y}
   (X.1*Y.1)|{AndGate X.2 Y.2}
end
declare
fun{OrGate X Y}
   %if X.1==1 then X.1|{OrGate X.2 Y.2}
   %else Y.1|{OrGate X.2 Y.2}
   %end
   ((X.1+Y.1)-(X.1*Y.1))|{OrGate X.2 Y.2}
end

%Exo 2c
declare
fun{Simulate G Ss}
   case G of input(X) then Ss.X
   of gate(Y) then
      case Y.value of 'and' then {AndGate {Simulate Y.1 Ss} {Simulate Y.2 Ss}}
      [] 'or' then {OrGate {Simulate Y.1 Ss} {Simulate Y.2 Ss}}
      [] 'not' then {NotGate {Simulate Y.1 Ss}}
      end
   end
end

%Exo 2d
%logic gates are consumer :P
