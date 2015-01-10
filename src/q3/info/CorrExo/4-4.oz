declare
fun {F}
   fun {Fibo A B}
      fib(A+B fun{$} {Fibo B A+B} end)
   end
in
   {Fibo 0 1}
end
