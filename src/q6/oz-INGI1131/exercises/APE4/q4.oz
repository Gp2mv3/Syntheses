% Without Table, at second 36, the numbers of beers on the table is 5 !
% With Table, Bar is blocked waiting on a free place on the table.
declare
fun {Foo Beers Table}
   case Beers
   of H|T then
      local Ta in
         {Delay 1200}
         Table = free|Ta
         empty|{Foo T Ta}
      end
   end
end
fun {Bar Table}
   case Table
   of H|T then
      {Delay 50}
      full|{Bar T}
   end
end

Table = 1|2|3|4|_
Beers = thread {Bar Table} end
Ground = thread {Foo Beers {List.drop Table 4}} end
{Browse Beers}
{Browse Ground}
