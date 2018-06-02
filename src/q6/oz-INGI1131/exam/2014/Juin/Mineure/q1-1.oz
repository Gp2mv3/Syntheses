fun {DelayG Xs}
   0|Xs
end
fun lazy {Add Xs Ys}
   X|Xr = Xs
   Y|Yr = Ys
in
   (X+Y)|{Add Xr Yr}
end
fun lazy {Prod N}
   N|{Prod N+1}
end
proc {Circuit ?A ?B ?C}
   A = {Prod 0}
   B = {DelayG C}
   C = {Add A B}
end
