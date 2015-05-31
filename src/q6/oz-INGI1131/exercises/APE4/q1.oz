%a
declare
local X Y Z in
   X= Y+Z
   Y= 1
   Z= 2
   {Browse X}
end

local X Y Z in
   X= plus(Y Z)
   Y= 1
   Z= 2
   {Browse X}
end

%A la premiere question l operation est executee sans meme qu Y et Z n'aient de valeurs et est attribuee a X. Il ne peut donc pas avoir de valeur.
%A la seconde la fonction appelee attend les valeurs d Y et Z avant de s'executer.

%b
local X Y Z in
   thread X= Y+Z end
   Y= 1
   Z= 2
   {Browse X}
end
