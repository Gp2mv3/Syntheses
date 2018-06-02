declare

%Question 3
class BankAccount
   attr money
   meth init
      money := {NewCell 0}
   end
   meth deposit(Amount)
      Old New
   in
      {Exchange @money Old New}
      New = Old + Amount
   end
   meth withdraw(Amount)
      {self deposit(~Amount)}
   end
   meth getBalance($)
      @@money
   end
end

Account = {New BankAccount init}
X1 X2
thread {Account deposit(100)} X1 = unit end
thread {Account withdraw(58)} X2 = unit end
{Wait X1} {Wait X2} % Barrier :)
{Browse {Account getBalance($)}}

% Question 4
Lock = {NewLock}
proc {Transfer Amount Account1 Account2}
   lock Lock in
      {Account1 withdraw(Amount)}
      {Account2 deposit(Amount)}
   end
end