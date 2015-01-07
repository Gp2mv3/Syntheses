declare
fun {InsertElements L OT}
   fun {InsertElement E OT}
      case OT of leaf then tree(key:E value:E leaf leaf)
      []tree(key:K value:V L R) then
	 if E<K then tree(key:K value:V {InsertElement E L} R)
	 elseif E>K then tree(key:K value:V L {InsertElement E R})
	 end
      end
   end
   fun{LoopList List OT}
      case List of nil then OT
      []H|T then {LoopList T {InsertElement H OT}}
      end
   end
in
   {LoopList L OT}
end

{Browse {InsertElements [42 17 23] tree(key:31 value:31 leaf leaf)}}