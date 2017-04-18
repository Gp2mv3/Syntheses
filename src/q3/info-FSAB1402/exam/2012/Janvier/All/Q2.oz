declare
fun{NewStack}
   C={NewCell nil}
   proc{Push X} C :=X|@C end
   proc{Pop X} S = @C in X = S.1 C := S.2 end
   proc{IsEmpty B} B = (@C == nil) end
in
   stack(push: Push pop: Pop isempty: IsEmpty)
end
S={NewStack}
{S.push a}
{S.push b}
{Browse {S.pop}}
{Browse {S.pop}}
{Browse {S.pop}}
