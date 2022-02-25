

%----------------------------Question 1 ------------------------------%

%Traduire en langage noyau

declare
fun {Sum N}
    if N == 1 then 1
    else N*N + {Sum N-1} end
end


% Donne

declare Sum in
proc {Sum N ?R}
    local B Zero in
        Zero = 0
        B = (N == Zero)
        if B then
            R = 0
        else
            local R1 N1 One in
                One = 1
                N1 = N-One
                {Sum N1 ?R1}
                R = N*N + R1
            end
        end
    end
end



%{Browse {Sum 3}} %Affiche 14

% Seconde question

declare
fun {SumAux N Acc}
    if N == 1 then Acc + 1
    else {SumAux N-1 N*N+Acc} end
end

fun {Sum N}
    {SumAux N 0}
end


% Donne

declare KernelSumAux KernelSum Acc in
proc {KernelSumAux N Acc ?R}

    local One B1 in
        One = 1
        B1 = N==One
        
        if B1 then R = Acc+One
        else
            local N1 B2 B3 in
                N1 = N-One
                B2 = N*N
                B3 = B2 + Acc
                {KernelSumAux N1 B3 R}
            end
        end
    end
end
proc {KernelSum N ?R}
    R = {KernelSumAux N 0}
end

%{Browse {KernelSum 3}}

local P Q in
    proc {P A R} R=A+2 end
    local P R in
        fun {Q A}
            {P A R}
            R
        end
        proc {P A R} R=A-2 end
    end
    %{Browse {Q 4}}%% Qu'affiche {Browse {Q 4}} ? %Affiche 2
end




 %% Programme 2
local Res in
    local Arg1 Arg2 in
        Arg1=7 % 1
        Res=Arg1*Arg2 % 3   %Ne semble rien afficher
        Arg2 = 6 %2
    end
    {Browse Res}
end   


local MakeAdd Add1 Add2 in
    proc {MakeAdd X Add} %Permet de créer un Adder
        proc {Add Y Z}
            Z=X+Y
        end
    end
    {MakeAdd 1 Add1}
    {MakeAdd 2 Add2}


    local V in
        {Add1 42 V} 
        {Browse V}
    end

    local V in
        {Add2 42 V} 
        {Browse V}
    end

    

end



