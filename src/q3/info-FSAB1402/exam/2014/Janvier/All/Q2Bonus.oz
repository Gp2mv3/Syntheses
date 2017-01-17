proc {MMap ML F R}
   case @ML
   of H|MT then
      local A in
	 R ={Cons {F H} A}
	 A ={MMap MT F}
      end
   [] nil then
      R = {Nil}
   end
end
