local P in
    P = {NewCell nil}
    for E in L do
        P := E|@P
    end
    @P
end