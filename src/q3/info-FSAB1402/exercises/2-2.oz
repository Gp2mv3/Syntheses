declare
fun {MainMirror Int}
   local Mirror in
      fun {Mirror Int Acc}
	 if Int==0 then Acc
	 else {Mirror (Int div 10) (Int mod 10)+Acc*10}
	 end
      end
      {Mirror Int 0}
   end
end

{Browse {MainMirror 987654321}}