declare
%% Delay random time. Print job's type. Bind the flag.
proc {Job Type Flag}
   {Delay {OS.rand} mod 1000}
   {Browse Type}
   Flag=unit
end
%% BuildPs binds Ps to a tuple of process descriptions.
%% Each process is assigned a random type
proc {BuildPs N Ps}
   Ps={Tuple.make '#' N}
   for I in 1..N do
      Type={OS.rand} mod 10
      Flag
   in
      Ps.I=ps(type:Type job:proc {$} {Job Type Flag} end flag:Flag)
   end
end
%% Launching 100 processes
N=100
Ps={BuildPs N}
for I in 1..N do
   thread {Ps.I.job} end
end



proc {WatchPs I Ps}
   for J in 1..N do
      if Ps.J.type == I then
         {Wait Ps.J.flag}
      end
   end
   {Browse 'All threads of type I are finished'}
end

{WatchPs {OS.rand} mod 10 Ps}
