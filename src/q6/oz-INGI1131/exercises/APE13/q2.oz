declare
% First version
fun {IncrementBad C}
   Old
in
   {Exchange C Old Old+1}
   C
end
% in kernel language, il is
fun {IncrementBadKernel C}
   Old Tmp
in
   Tmp = Old+1
   {Exchange C Old Tmp}
   C
end
% since we cannot do an operation in a proc call.
% It is now obvious that we wait indefinitely for the unbound variable Old
% Here is a simple fix
fun {Increment C}
   Old New
in
   {Exchange C Old New}
   New = Old + 1
   C
end
C = {NewCell 0}
{Browse @{Increment C}}