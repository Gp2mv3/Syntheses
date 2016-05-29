%Exo 3
declare A B C D in
thread D=C+1 end
thread C=B+1 end
thread A=1 end
thread B=A+1 end
{Browse D}

%On ne peut connaitre l'ordre d'execution des threads car c'est aleatoire.
%Par contre, on connait l'ordre d'evaluation des threads (qui dans ce cas ci ne sont composes que d'une instruction qui est forcement evaluee en meme temps que le thread).  Le thread qui initialise A finira en premier, puis celui initialisant B, puis C puis D.