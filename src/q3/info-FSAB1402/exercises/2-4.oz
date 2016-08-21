local Foo
   fun {FooHelper N Acc}
      if N<10 then Acc+1
      else {FooHelper (N div 10) Acc+1}
      end
   end
in
   fun {Foo N}
      {FooHelper N 0}
   end
end

{Browse {Foo 123456}}
{Browse {Foo 3211}}
{Browse {Foo 0}}
{Browse {Foo ~666}}