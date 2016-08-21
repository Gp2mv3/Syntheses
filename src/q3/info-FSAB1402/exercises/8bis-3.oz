declare
local
   class Node
      attr
	 previous %Lien vers le Node precedent
	 next %Lien vers le Node suivant
	 value %Valeur portee
      meth init(Val)
	 value:= Val
	 next:= nil
	 previous:= nil
      end
      meth getP($)
	 @previous
      end
      meth getN($)
	 @next
      end
      meth setP(NodeP)
	 previous:= NodeP
      end
      meth setN(NodeN)
	 next:= NodeN
      end
      meth getV($)
	 @value
      end
   end
in
   class Sequence
      attr
	 first
	 last
      meth init 
	 first:=nil
	 last:=@first
      end
      meth isEmpty($) @first==nil end
      meth first($) {@first getV($)} end
      meth last($) {@last getV($)} end
      meth insertFirst(X)
	 Newnode={New Node init(X)}
      in
	 if {self isEmpty($)} then
	    first:=Newnode last:=@first
	 else
	    {Newnode setN(@first)} %relier le nouveau noeud
	    {@first setP(Newnode)}%relier le premier noeud
	    first:=Newnode %remplacer le premier noeud
	 end
      end
      meth insertLast(X)
	 Newnode={New Node init(X)}
      in
	 if {self isEmpty($)} then
	    first:=Newnode
	    last:=Newnode
	 else
	    {Newnode setP(@last)}  %relier le nouveau noeud
	    {@last setN(Newnode)} %relier le dernier noeud
	    last:=Newnode %remplacer le dernier noeud
	 end
      end
      meth removeFirst
	 if @first==@last then first:=nil
	 else
	    first:={@first getN($)}
	 end
      end
      meth removeLast
	 if @first==@last then
	    first:=nil
	    last:=nil
	 else
	    last:={@last getP($)}
	 end
      end
   end
end


declare
fun {Palindrome Xs}
   S={New Sequence init}
   fun {Check}
      if {S isEmpty($)} then true
      elseif {S first($)}=={S last($)} then {S removeFirst} {S removeLast} {Check}
      else false
      end
   end
in
   for I in Xs do
      {S insertLast(I)}
   end
   {Check}
end

%{Browse {Palindrome [a b c d e f]}}
%{Browse {Palindrome [a b c b a]}}
%{Browse {Palindrome [e l u p a r c e t t e c r a p u l e]}}