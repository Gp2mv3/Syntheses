declare
fun {DelayG Xs}
   0|Xs
end
fun {NotG Xs}
   fun lazy {NotLoop Xs}
      case Xs
      of X|Xr then
         (1-X)|{NotG Xr}
      end
   end
in
   thread {NotLoop Xs} end % The thread here is useless since fun lazy already creates one
end

E
D = {DelayG E}
E = {NotG D}
{Browse D}      % Show 0|_, it does not produce anything more since NotG is lazy and Browse does not trigger a Wait
                % We nead to wait for the content of D with fore example
{Wait D.2.2.2}  % to show something

% If NotG was not lazy, it would produce all the infinite output stream even if it is not needed
% We would use the not lazy version if we wanted to stream independently of any user of the stream
% or if we know that we will need all the stream as fast as possible.
% The lazy version would be used in application where the need of the stream depends and/or is
% slower than the production.