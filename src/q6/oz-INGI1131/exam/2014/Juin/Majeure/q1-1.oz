fun {DelayG Xs}
   0|Xs
end
fun {NotG Xs}
   fun {NotLoop Xs}
      X|Xr = Xs
   in
      (1-X)|{NotLoop Xr}
   end
in
   thread {NotLoop Xs} end
end
