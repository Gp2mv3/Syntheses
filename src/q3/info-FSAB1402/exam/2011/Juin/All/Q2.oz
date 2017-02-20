local
   C = {NewCell 1}
   D = {NewCell 2}
   proc{F1 C}
      C:= @C +4
   end
   proc{F2 D}
      C:=@C+8
      D:=@D+16
   end
in
   {F1 D}
   {F2 C}
   {Browse @C}
   {Browse @D}
end
