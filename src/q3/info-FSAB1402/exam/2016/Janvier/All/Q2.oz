local
   C={NewCell 0}
   fun{F A}
      fun{$ B}
	 A+@C+{B}
      end
   end
in
   {Browse {{F 1} fun{$} C:=@C+1 @C end}}
end
