% a (propriete du reste)
declare
fun{PGCD M N} %M>=N
   if M mod N ==0 then N
   else {PGCD N ( M mod N)}
   end
end

{Browse {PGCD 35 7}}
{Browse {PGCD 48 36}}

% a bis (methode instinctive)
declare
fun {Min X Y}
   if X<Y then X else Y end
end

declare
fun {PGCD N M}
   fun{Div X}
      if X==1 then 1
      elseif (N mod X)==0 then  
	 if(M mod X)==0 then X else {Div X-1} end
      else {Div X-1} end
	 
   end
in
   {Div {Min N M}}
end

{Browse {PGCD 35 14}}

% b

declare
fun {PPCM N M}
   (N*M div {PGCD N M})
end

{Browse {PPCM 36 48}}