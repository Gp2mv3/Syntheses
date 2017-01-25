declare
fun{Claque4 L}
   case L of
      H1|H2|H3|H4|T then H4|H3|H2|H1|{Claque4 T}
   else nil
   end
end
fun{ClaqueK K L}
   local Boucle C in
      fun{Boucle N A}
	 if N == 0 then A
	 else {Boucle N-1 {List.nth L K-N+1}|A}
	 end
      end
      
      if {List.length L $} < K then nil
      else
	 C = {ClaqueK K {List.drop L K $}}
	 {Boucle K C}
      end
   end
end

  
{Browse {Claque4 [vous etes le phenix des hotes de ces bois]}}
{Browse {ClaqueK 3 [a ces mots le corbeau ne se sent pas de joie]}}