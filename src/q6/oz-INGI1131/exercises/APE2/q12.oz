declare
fun {DictionaryFilter D F}
  case D 
  of leaf then nil
  [] dict(key:Key info:Info left:Left right:Right) then
      DicL = {DictionaryFilter Left F}
      DicR = {DictionaryFilter Right F}
  in
      if({F Info})then
          {Append DicL Key#Info|DicR}
      else
          {Append DicL DicR}
      end
  end  
end

Class=dict(key:10 info:person('Christian'19) left:dict(key:7 info:person('Denys'25) left:leaf right:dict(key:9 info:person('David'7) left:leaf right:leaf)) right:dict(key:18 info:person('Rose'12) left:dict(key:14 info:person('Ann'27) left:leaf right:leaf) right:leaf))

{Browse {DictionaryFilter Class fun {$ Info}Info.2>20 end}} %->[7#person('Denys' 25) 14#person('Ann' 27)]