local MakeAdder A Add in
   A=10
   fun {MakeAdder X} fun {$ Y} Y+X end end
   Add={MakeAdder A}
   {Browse {Add 100}}
end