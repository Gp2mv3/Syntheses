local I = {NewCell S} in
   local Temp= {NewCell nil} in
      for C in @I do
	 Temp := C|@Temp
      end	
      @Temp
   end
end