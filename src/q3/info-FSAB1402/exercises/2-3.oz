declare
fun {Foo N}
   if N<10 then 1
   else 1+{Foo (N div 10)}
   end
end
%fct qui calcule le nombre de chiffres

{Browse {Foo 123456}}
{Browse {Foo 3211}}
{Browse {Foo 0}}
{Browse {Foo ~666}}