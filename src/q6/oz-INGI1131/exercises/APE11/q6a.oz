declare
class Counter
   attr count
   meth init
      count := 0
   end
   meth add(N)
      count := @count + N
   end
   meth read($)
      @count
   end
end

fun {Q A B}
   Count = {New Counter init}
in
   for I in A..B do
      {Count add(I)}
   end
   {Count read($)}
end

{Browse {Q 2 10}}