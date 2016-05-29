%Exo 4
declare
proc{WaitOr X Y}
   local Z in
      Z={Record.waitOr X#Y}%Utilisation d'une fonction de librairie.
   end
end

%Bonne reponse
declare
proc {WaitOr X Y}
   Z in
   thread {Wait X} Z=1 end
   thread {Wait Y} Z=1 end
   {Wait Z}
end