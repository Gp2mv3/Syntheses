declare Bosses
fun{Bosses L}
   local 
      fun{SubBosses L R}
	 case L of T|nil then nil
	 [] H|T then if H=<T.1 then {SubBosses T R+1}
		     else R|{SubBosses T R+1}
		     end
	 end
      end
   in
      {SubBosses L 1}
   end
end

declare
fun{Perm L I}
   local
      fun{SubPerm L I R}
	 case L of nil then nil
	 [] H|T then if R\=I then H|{SubPerm T I R+1}
		     else T.1|H|{SubPerm T.2 I R+1}
		     end
	 end
      end
   in
      {SubPerm L I 1}
   end
end

declare
fun{Tri L}
   case {Bosses L} of nil then L
   [] H|T then {Tri {Perm L {Bosses L}.1}}
   end
end


   

