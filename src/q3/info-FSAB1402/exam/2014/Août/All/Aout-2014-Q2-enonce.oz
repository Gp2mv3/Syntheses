local
   fun {MakeCla}
      D={NewCell 0}
   in
      fun {$}
	 C={NewCell 0}
      in
	 fun {$}
	    D :=@D+1
	    C :=@C+@D
	    @C
	 end
      end
   end
   MakeObj={MakeCla}
   Obj1={MakeObj}
   Obj2={MakeObj}
in
   {Browse [{Obj1} {Obj2} {Obj1} {Obj2}]}
end