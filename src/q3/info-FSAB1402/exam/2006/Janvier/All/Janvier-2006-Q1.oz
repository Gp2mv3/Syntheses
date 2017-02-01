declare
fun{Scie Xs Ys}
   fun{ScieMult Ys Ynew K}
      if K==1 then Ynew
      else {ScieMult Ys {Append Ys Ynew} K-1}
      end
   end
   fun{ScieHelper Xs Y Zs}
      if Xs==nil then Zs
      else {ScieHelper Xs.2 Y.2 {Append Zs (Xs.1*Y.1)|nil}}
      end
   end
in
   {ScieHelper Xs {ScieMult Ys Ys {Length Xs}div{Length Ys}} nil}
end