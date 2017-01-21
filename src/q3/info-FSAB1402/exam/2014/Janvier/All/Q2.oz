local
   fun {Nil} {NewCell nil} end
   fun {Cons A B} {NewCell A|B} end
   fun {MMap ML F}
      case @ML
      of H|MT then
	 {Cons {F H} {MMap MT F}}
      [] nil then
	 {Nil}
      end
   end
   ML1={Cons 4 {Cons 5 {Cons 6 {Nil}}}}
   ML2 N=3
in
   ML2={MMap ML1 fun {$ X} N*X*X end}
   {Browse (@((@ML2).2)).1}
end