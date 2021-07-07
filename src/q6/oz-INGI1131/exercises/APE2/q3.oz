%a
local
   X Y
in
   {Browse 'hello nurse'}
   X=2+Y%the + is a blocking operation.
   {Browse X}%nothing is printed
   Y=40
end

%b
local
X Y
   fun {Sum A B}
      A+B
   end
in
   {Browse 'hello nurse'}
   X=sum(2 Y)%this is an atom
   {Browse X}%prints sum(2 40)
   Y=40
end
