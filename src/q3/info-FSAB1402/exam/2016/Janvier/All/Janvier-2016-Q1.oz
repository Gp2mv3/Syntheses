declare
fun {Match P Q}
%P et Q sont des matrices (listes de listes). P est plus petite que Q.
%Renvoie yes si SubMatch est true pour chaque sous liste de P
   local
      fun {SubMatch A B}
%A et B sont des listes. A est plus petite que B
%true si MatchPoint est true pour tous les elements de A
	 case A#B of nil#T then true
	 [](H|T)#(G|S) then
	    if H+G==2 then false
	    else {SubMatch T S}
	    end
	 end
      end
   in
      case P
      of nil then 'yes'
      []H|T then
	 case Q of G|S then
	    if {SubMatch H G} then {Match T S}
	    else 'no'
	    end
	 end
      end
   end
end

fun{Find P Q}
   local
      fun{Extract A J I}
	 local
	    fun{Enleve A}%Enleve la 1e colonne
	       case A of H|T then H.2|{Enleve A.2}
	       else nil
	       end
	    end
	 in
	    if I==1 then
	       if J==1 then A
	       else
		  {Extract {Enleve A} J-1 I}
	       end 
	    else
	       {Extract A.2 J I-1}
	    end
	 end
      end
      fun{Found B J I}
	 if {Match P B}=='yes' then found(I J)
	 else
	    if J=={Length Q.1}-{Length P.1}+1 then
	       if I=={Length Q}-{Length P}+1 then 'notfound'
	       else {Found {Extract Q 1 I+1} 1 I+1}
	       end
	    else
	       {Found {Extract Q 1+J I} 1+J I}
	    end
	 end
      end
   in
      {Found Q 1 1}
   end
end

P = [ [1 0 0] [1 1 1]]
Q = [ [1 1 0 0] [1 1 0 0] [1 0 1 1] [1 0 0 0]]
{Browse {Find P Q}}