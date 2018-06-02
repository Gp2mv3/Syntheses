proc {F X1 ... Xn ?R}
   thread
      {WaitNeeded R}
      Y = <expr>
   end
end

% The {WaitNeeded Y} will wait (i.e. the thread is blocked) until the variable Y is needed.
% A variable is needed on a supended operation if the value of the variable must be determined for the operation to continue.
% This is the case of operators like '+', '==', '<', ...

declare
proc {F X ?R}          % 3.  In the CE, X->z et R->y
   thread              % 4.  A new thread is created
      {WaitNeeded R}   % 5b. The secondary thread is suspended here since no operation needs the value of y to continue
      R = X + 1
   end
end                    % 5a. The main thread continues here
Y = {F 10}             % 1.  Execution starts here, Y is created with an unbound variable in memory y (Y -> y).
                       % 2.  Another variable is created in kernel language (let's say Z -> z) with z = 10.
                       % 6a. And then finishes

% A lazy suspension is a suspension of a thread (which means that the threads goes in a suspended state) untils a variable is needed.