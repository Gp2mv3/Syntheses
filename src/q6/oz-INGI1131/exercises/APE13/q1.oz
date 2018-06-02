% No it is not correct the two lines of send should be made atomic
% We don't need a lock here we can just use Exchange
declare
proc {NewPort S P}
   P = {NewCell S}
end

proc {Send P Msg}
   NewTail
in
   {Exchange P Msg|NewTail NewTail}
end