fun{Producer N}
    fun{Liste X N}
        if X > N then nil
        else X|{Liste X+1 N} end
    end
in
    {Liste 1 N}
end
fun{Consumer S}
    case S of X|Y then X+{Consumer Y}
    else 0
    end	
end
fun{Filter S}
    case S of X|Y then
        if X mod 2 \= 0 then 
            X|{Filter Y}
        else {Filter Y}
        end
    else nil
    end
end
local Ouk Zero in
    thread Ouk = {Producer 20} end
    thread Zero = {Filter Ouk} end
    thread {Browse {Consumer Zero}} end
end	