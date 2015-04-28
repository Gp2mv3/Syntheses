declare

% Question 1
proc {ReadList Xs}
   case Xs
   of nil then skip
   [] X|Xr then {Browse X} {ReadList Xr}
   end
end

% Question 2
% Si on browse le stream du port on obtient juste un stream
% qui se remplit au fur et a mesure des Send.
% browser le port lui meme donne juste "<Port>"

% Question 3
% Fonction qui renvoit un nouveau port
% et qui utilise ReadList sur son input stream
% pour browse chaque element envoye au port
fun {PortBrowser}
   Sin in
   thread {ReadList Sin} end
   {NewPort Sin}
end

P = {PortBrowser}
{Send P coucou}
{Send P hello}
