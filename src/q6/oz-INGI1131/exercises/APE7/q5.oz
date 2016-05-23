%Exo 5
declare
fun{WaitOrValue X Y}
   Z in
   thread {Wait X} Z=X end
   thread {Wait Y} Z=Y end
   {Wait Z}
   Z
end