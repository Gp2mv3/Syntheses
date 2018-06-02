%Exo 4
declare
fun lazy {Gen I N}
   {Delay 500}
   if I==N then [I] else I|{Gen I+1 N} end
end
fun lazy {Filter L F}
   case L of nil then nil
   [] H|T then
      if {F H} then H|{Filter T F} else {Filter T F} end
   end
end
fun lazy {Map L F}
   case L of nil then nil
   [] H|T then {F H}|{Map T F}
   end
end

%threads --> remove the lazy on the functions above before running.

declare Xs Ys Zs
{Browse Zs}
thread {Gen 1 100 Xs} end
thread {Filter Xs fun {$ X} (X mod 2)==0 end Ys} end
thread {Map Ys fun {$ X} X*X end Zs} end

%lazy

declare Xs Ys Zs
{Browse Zs}
{Gen 1 100 Xs}
{Filter Xs fun {$ X} (X mod 2)==0 end Ys}
{Map Ys fun {$ X} X*X end Zs}
{Touch Zs 25}