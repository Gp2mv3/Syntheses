declare
fun {Incorpore L1 L2}
   case L1#L2
   of (H1|T1)#(H2|T2) then
      if H1==H2 then {Incorpore T1 T2}
      else {Incorpore L1 T2}
      end
   [] (H1|T1)#nil then false
   else true
   end
end
fun {Apex LL}
   local
      N={Length LL}
      fun {Check1 LL M} %Verifie si {Incorpore L_k L_{k-1}} (0<=k<=M)
         if M==0 then true
         else
            if {Incorpore {Nth LL M+1} {Nth LL M}} then  {Check1 LL M-1}
            else false
            end
         end
      end
      fun {Check2 LL M} %Verifie si {Incorpore L_{k-1} L_k} (M<k<=N-1)
         if M==N-1 then true
         else
            if {Incorpore {Nth LL M+1} {Nth LL M+2}} then  {Check2 LL M+1}
            else false
            end
         end
      end
      fun {ApexAux LL Q Res} % Verifie si L_Q est un apex
         if Q==N then       % Res est l'apex deja trouve (nil sinon)
            if Res==nil then false
            else Res
            end
         else
            if ({Check1 LL Q} andthen {Check2 LL Q}) then
               if Res==nil then {ApexAux LL Q+1 {Nth LL Q+1}}
               else false
               end
            else {ApexAux LL Q+1 Res}
            end
         end
      end
   in
      {ApexAux LL 0 nil}
   end
end
