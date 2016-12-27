fun {$ X}
   local fun {Bouc D C}
	    case D of H|T then 
	       if H == X then C.1
	       else {Bouc D.2 C.2}
	       end
	    [] nil then 'bottom'
	    end
	 end
   in
      {Bouc D C}
   end
end