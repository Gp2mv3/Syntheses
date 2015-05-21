fun {Circuit}
   B = {NotG A}
   C = {DelayG B}
   A = {DelayG C}
in
   A
end
