attr a
meth init a := nil end
meth put(X) a:= X|@a end
meth get($) 
   local X in 
      X = @a.1 
      a:= (@a.2) 
      X 
   end 
end
meth isEmpty($) if @a == nil then true else false end end
meth union(C)
   local Y in
      {C isEmpty(Y)}
      if Y == false then
	 local X in
	    {C get(X)}
	    {self put(X)}
	    {self union(C)}
	 end
      end
   end
end