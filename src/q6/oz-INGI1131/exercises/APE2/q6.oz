declare
fun {Add A B}
  fun {AddDigits A B C}
      SUM = A+B+C
      OUT = output(sum:_ carry:_)
  in
      case SUM
      of 0 then OUT.sum=0 OUT.carry=0
      [] 1 then OUT.sum=1 OUT.carry=0
      [] 2 then OUT.sum=0 OUT.carry=1
      [] 3 then OUT.sum=1 OUT.carry=1
      end
      OUT
  end

  fun {Loop A B}
      Prev
      Addition
  in
      if A==nil then output(r:nil carry:0)
      else
          Prev = {Loop A.2 B.2}
          Addition = {AddDigits A.1 B.1 Prev.carry}
          output(r:Addition.sum|Prev.r carry:Addition.carry)
      end
  end
  Addition = {Loop A B}
in
  Addition.carry|Addition.r
end

{Browse {Add [1 1 0 1 1 0] [0 1 0 1 1 1]}} % -> [1 0 0 1 1 0 1]