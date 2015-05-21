declare
fun {NewPortObject F Init}
   Xs
   P = {NewPort Xs}
   proc {Loop State Ms}
      M|Mr = Ms
   in
      {Loop {F State M} Mr}
   end
in
   thread {Loop Init Xs} end
   P
end
fun {MakeAgent Id Neighbors}
   fun {F State M}
      I = M.1
   in
      if I \= Id then
         {Browse Id#forward#I}
         if I =< Id - 6 then
            {Send Neighbors.1 M}
         elseif I =< Id then
            {Send Neighbors.2 M}
         elseif I =< Id + 5 then
            {Send Neighbors.3 M}
         else
            {Send Neighbors.4 M}
         end
         State
      else
         case M
         of set(I A) then
            {Browse Id#set#I}
            A
         [] get(I X) then
            {Browse Id#get#I}
            X = State
            State
         end
      end
   end
in
   {NewPortObject F none}
end

% Inspired from http://www.forum-epl.be/viewtopic.php?p=80881#80881
fun lazy {LDrop L N}
   {List.drop L N}.1
end

fun {MakeHelix}
   S L = N|N|N|N|N|N|N|N|N|N|S
   N = {DumpError}
   fun lazy {Rec I L Self}
      P = {List.drop L 9}
      N = {LDrop Self 1}
      NN = {LDrop Self 10}
      V = v(L.1 P.1 N NN)
   in
      {MakeAgent I V}|{Rec I+1 L.2 Self.2}
   end
in
   S = {Rec 0 L S}
   S.1
end

fun {DumpError}
   {NewPortObject fun {$ _ M} raise negativeI(M) end end _}
end

H = {MakeHelix}
{Send H set(28 marvin)}
{Browse {Send H get(28 $)}}