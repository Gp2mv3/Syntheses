declare
class Collection
   attr elements
   meth init   % initialise la collection
      elements:=nil
   end
   meth put(X)   % insere X
      elements:=X|@elements
   end
   meth get($)   % extrait un element et le renvoie
      case @elements of X|Xr then elements:=Xr X end
   end
   meth isEmpty($)   % renvoie true ssi la collection est vide
      @elements==nil
   end
   meth union(C)
      if {C isEmpty($)} == false then
	 V = {C get($)}
      in
	 {self put(V)}
	 {self union(C)}
      end	 
   end  
end


class SortedCollection
   from Collection
      
   meth put(X)   % insere X
      fun{PutAux L}
	 case L of nil then X|nil
	 [] H|T then
	    if X=<H then X|H|T
	    else
	       H|{PutAux T}
	    end
	 end
      end
   in     
      elements:={PutAux @elements}
   end
end

% test zone
C1={New SortedCollection init}

{C1 put(5)}
{C1 put(3)}
{C1 put(6)}

{Browse {C1 get($)}}
{Browse {C1 get($)}}
{Browse {C1 get($)}}