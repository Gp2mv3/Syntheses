%% a) without ports
local
   
   fun {WaitTwo X Y}
      {Record.waitOr '#'(X Y)}
   end

   fun {Prod E}
      {Delay {OS.rand} mod 4000 + 1000}
      E|{Prod E+1}
   end

   fun {StreamMerger S1 S2}
      if {WaitTwo S1 S2} == 1 then
	 case S1 of H1|T1 then
	    H1|{StreamMerger T1 S2}
	 end
      else
	 case S2 of H2|T2 then
	    H2|{StreamMerger S1 T2}
	 end
      end
   end

   A B C

in
   thread A = {Prod 100} end
   thread B = {Prod 200} end
   
   {Browse A}
   {Browse B}

   thread C = {StreamMerger A B} end

   {Browse C}
end


%% a) using ports


local

   fun {StreamMergerP S1 S2}
      proc {Sender S}
	 case S of H|T then
	    {Send P H}
	    {Sender T}
	 end
      end

      P S
   in
      {NewPort S P}
      thread {Sender S1} end
      thread {Sender S2} end
      S
   end

   fun {Prod E}
      {Delay {OS.rand} mod 4000 + 1000}
      E|{Prod E+1}
   end

   A B C

in

   thread A = {Prod 100} end
   thread B = {Prod 200} end
   
   {Browse A}
   {Browse B}
   {Browse {StreamMergerP A B}}
end
