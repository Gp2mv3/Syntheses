declare
fun{Claque4 L}
   case L of
      H1|H2|H3|H4|T then H4|H3|H2|H1|{Claque4 T}
   else nil
   end
end
fun {ClaqueK K L}
   if {List.length L} >= K then {Append {List.reverse {List.take L K}} {ClaqueK K {List.drop L K}}}
   else nil
   end
end

  
{Browse {Claque4 [vous etes le phenix des hotes de ces bois]}}
{Browse {ClaqueK 3 [a ces mots le corbeau ne se sent pas de joie]}}
