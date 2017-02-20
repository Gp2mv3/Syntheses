% a
declare
fun {Prime N}
   local Divide in
      fun {Divide Num Acc}
	 if Acc==false then false
	 elseif Num==0 then false
	 elseif Num==1 then true
	 else {Divide Num-1 (N mod Num)\=0}
	 end
      end
      {Divide N-1 true}
   end
end

{Browse {Prime 0}}
{Browse {Prime 1}}
{Browse {Prime 7}}
{Browse {Prime 25}}

% b
declare
fun{PrimeAux M  N}
   fun{Divide K}
      if K==N then true
      elseif (N mod K)== 0 then false
      else {Divide  K+1}
      end
   end
in
   {Divide M}
end
   
fun {Prime2 N}
   if N>1 then {PrimeAux 2 N}
   else false
   end
end

{Browse {Prime2 0}}
{Browse {Prime2 1}}
{Browse {Prime2 7}}
{Browse {Prime2 25}}

% c
declare
fun{PrimeAux M  N}
   fun{Divide K}
      if K*K>N then true
      elseif (N mod K)== 0 then false
      else {Divide  K+1}
      end
   end
in
   {Divide M}
end
   
fun {Prime3 N}
   if N>1 then {PrimeAux 2 N}
   else false
   end
end

{Browse {Prime3 0}}
{Browse {Prime3 1}}
{Browse {Prime3 7}}
{Browse {Prime3 4}}