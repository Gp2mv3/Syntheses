declare
class Expression % classe abstraite!
  attr v1 v2
  meth init(X Y) v1:=X v2:=Y end
  meth evalue($) 
    local A B in
      {@v1 evalue(A)}
      {@v2 evalue(B)}
      {self compute(A B $)}
    end
  end
end

class Somme from Expression
   meth compute(A B R) R= A+B end
   meth derive(Var Out)
      Out = {New Somme init({@v1 derive(Var $)} {@v2 derive(Var $)})}
   end
   
end

class Difference from Expression
   meth compute(A B R) R= A-B end
   meth derive(Var Out)
      Out = {New Difference init({@v1 derive(Var $)} {@v2 derive(Var $)})}
   end
end

class Produit from Expression
   meth compute(A B R) R = A*B end
   meth derive(Var Out)
      FirstPart SecondPart
   in
      FirstPart = {New Produit init({@v1 derive(Var $)} @v2)}
      SecondPart = {New Produit init({@v2 derive(Var $)} @v1)}
      Out = {New Somme init(FirstPart SecondPart)}	 
   end
end

class Division from Expression
   meth compute(A B R) R = A div B end
   meth derive(Var Out)
      NumFirstPart NumSecondPart Denum Num
   in
      NumFirstPart = {New Produit init({@v1 derive(Var $)} @v2)}
      NumSecondPart = {New Produit init({@v2 derive(Var $)} @v1)}
      Num = {New Difference init(NumFirstPart NumSecondPart)}
      
      Denum = {New Puissance init(@v2 2)}
      
      Out = {New Division init(Num Denum)}	 
   end
end

class Puissance from Expression
   meth evalue($) 
      local A in
	 {@v1 evalue(A)}
	 {self compute(A @v2 $)}
      end
   end
   meth compute(A B R) R = {Pow A B} end
   meth derive(Var Out)
      Pow2
      Const
      Prod
   in
      Pow2 = {New Puissance init(@v1 @v2-1)}
      Const = {New Constante init(@v2)}
      Prod = {New Produit init(Const Pow2)}
      Out = {New Produit init(Prod {@v1 derive(Var $)})}
   end
end

class Variable
  attr v id % id sert a comparer deux variables
  meth init(X) v:=X id:={OS.rand} end
  meth set(X) v:=X end
  meth evalue(R) R = @v end
  meth getId($) @id end
  meth derive(Var Out)
     if {self getId($)} == {Var getId($)} then
	Out = {New Constante init(1)}
     else
	Out = {New Constante init(0)}
     end
  end
end

class Constante
  attr v
  meth init(X) v:=X end
  meth evalue(R) R = @v end
  meth derive(Var Out)    
      Out = {New Constante init(0)}	 
   end
end
    

% test zone
declare
VarX={New Variable init(0)}
VarY={New Variable init(0)}
local
   ExprX2={New Puissance init(VarX 2)}
   Expr3={New Constante init(3)}
   Expr3X2={New Produit init(Expr3 ExprX2)}
   ExprXY={New Produit init(VarX VarY)}
   Expr3X2mXY={New Difference init(Expr3X2 ExprXY)}
   ExprY3={New Puissance init(VarY 3)}
in
   Formule={New Somme init(Expr3X2mXY ExprY3)}
   {VarX set(7)}
   {VarY set(23)}
   {Browse {Formule evalue($)}}   % affiche 12153

   {VarX set(5)}
   {VarY set(8)}
   {Browse {Formule evalue($)}}   % affiche 547

   Derivee={Formule derive(VarX $)}   % represente 6x - y

   {VarX set(7)}
   {VarY set(23)}
   {Browse {Derivee evalue($)}}   % affiche 19

end
