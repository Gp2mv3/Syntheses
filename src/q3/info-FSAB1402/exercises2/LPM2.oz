local fun {Facto N A B}
        if A > N then nil
        else A*B | {Facto N A+1 A*B}
        end
	end
in
    if N < 1 then nil
    else {Facto N 1 1}
    end
end