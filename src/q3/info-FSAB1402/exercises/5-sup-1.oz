% a
declare
fun{NewTree23}
   leaf
end

% b
declare
fun{InsertElement El Tree23}
   case Tree23
   of leaf then tree23(El left:leaf right:leaf)
   []tree23(V left:L right:R) then
      if El==V then Tree23
      elseif El<V then 
	 case L
	 of tree23(Vl left:Ll right:Rl) then
	    if El>Vl then tree23(V left:L center:tree23(El left:leaf right:leaf)  right:R)
	    else tree23(V left:{InsertElement El L} right:R)
	    end
	 else
	    tree23(V  left:{InsertElement El L} right:R)
	 end
      else
	 case R
	 of tree23(Vr a b) then
	    if El<Vr then tree23(V left:L center:tree23(El left:leaf right:leaf)  right:R)
	    else tree23(V left:L right:{InsertElement El R})
	    end
	 else
	    tree23(V left:L right:{InsertElement El R})
	 end
      end
   []tree23(V left:L center:C right:R) then
      if El==V then Tree23
      elseif El<V then
	 case L
	 of tree23(Vl left:Ll center:Cl right:Rl) then
	    if El>Vl then tree23(V left:L center:{InsertElement El C}  right:R)
	    else tree23(V  left:{InsertElement El L} center:C right:R)
	    end
	 [] tree23(Vl left:Ll right:Rl) then
	    if El>Vl then tree23(V left:L center:{InsertElement El C}  right:R)
	    else tree23(V  left:{InsertElement El L} center:C right:R)
	    end
	 else
	    tree23(V  left:{InsertElement El L} center:C right:R)
	 end
      else
	 case R
	 of tree23(Vr left:Lr center:Cr right:Rr) then
	    if El<Vr then tree23(V left:L center:{InsertElement El C}  right:R)
	    else tree23(V left:L center:C right:{InsertElement El R})
	    end
	 []tree23(Vr left:Lr  right:Rr) then
	    if El<Vr then tree23(V left:L center:{InsertElement El C}  right:R)
	    else tree23(V left:L center:C right:{InsertElement El R})
	    end
	 else
	    tree23(V left:L center:C right:{InsertElement El R})
	 end
      end
   end
end


{Browse {InsertElement 2 {NewTree23}}}

declare
fun{AdTree23 List Tree23}
   case List
   of H|T then {AdTree23 T {InsertElement H Tree23}}
   else Tree23
   end
end

declare
T= [40 60 10 17 30 15 25 45] 
U={AdTree23 T {NewTree23}}
{Browse U}

% c

declare
fun {GetElements  Tree23}
   fun{Iter T Acc}
      case T
      of tree23(Key left:L right:R) then {Iter L Key|{Iter R Acc}}
      [] tree23(Key left:L center:C right:R) then {Iter L {Iter {InsertElement Key C} {Iter R Acc}}}
      else Acc
      end
   end
in
   {Iter Tree23 nil}
end

{Browse {GetElements U}}