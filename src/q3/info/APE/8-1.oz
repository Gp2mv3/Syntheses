declare
fun {Reverse L}
   local S in
      S = {NewCell nil}
      for M in L do
	 S:=M|@S
      end
      @S
   end
end
