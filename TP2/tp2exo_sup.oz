%---------------Séance 2 - Extra -------------------------------------------%

%Les extra de la séance 2 portent sur la programmation symbolique et les enregistrements


%----------Exercice 1 ------------------%

%cette fonction permet d'accéder à un élément de la liste
%en d'autre terme, de la retirer de la liste et ne garder que l'atome
declare 
fun {AtomSearcher Elem}
    nil
end


%Ensuite on implémente la fonction principale
declare
fun {Flatten L}
    nil
end

%{Browse {Flatten [a [b [c d]] e [[[f]]]]}} % affiche [a b c d e f]




%----------------Exercice 2 -----------------------------%

%Pas très optimal d'énumérer simplement 
declare 
fun {AddDigits D1 D2 CI}
    if CI == 0 then
        case D1#D2 
        of 0#0 then [0 0]
        [] 0#1 then [0 1]
        [] 1#0 then [0 1]
        [] 1#1 then [1 0]
        end
    else
        case D1#D2 
        of 0#0 then [0 1]
        [] 0#1 then [1 0]
        [] 1#0 then [1 0]
        [] 1#1 then [1 1]
        end
    end
end

%{Browse {AddDigits 1 0 0}} % affiche [0 1]
%{Browse {AddDigits 1 1 0}} % affiche [1 0]
%{Browse {AddDigits 1 0 1}} % affiche [1 0]
%{Browse {AddDigits 1 1 1}} % affiche [1 1]
%{Browse {AddDigits 0 1 1}} % affiche [1 0]


%Cette fonction permet de concaténer deux listes.
declare
fun {Append A B}
    case A
    of nil then B 
    [] H|T then H|{Append T B}
    end
end

declare 
fun {ReportTabMaker B1 B2}
    case B1#B2
    of nil#nil then 0|nil  %0|nil permet de décaler le tableau vers la gauche sans causer de problème
    [] (H1|T1)#(H2|T2) then
        if (H1 + H2) == 2 then
            1|{ReportTabMaker T1 T2}
        else
            0|{ReportTabMaker T1 T2}
        end
    end
end

%{Browse {ReportTabMaker [1 1 0 1 1 0] [0 1 0 1 1 1] }}

local Report in
    fun {Add B1 B2}
        fun {AddHelper B1 B2 R}
            case B1#B2
            of nil#nil then
                nil
            [] (H1|T1)#(H2|T2) then
                if ((H1+H2+R.1) mod 2) == 0 then
                    0|{AddHelper T1 T2 R.2}
                else
                    1|{AddHelper T1 T2 R.2}
                end
            end
        end
    
    in

        Report = {ReportTabMaker B1 B2}

        if Report.1 == 0 then
            {Append {AddDigits B1.1 B2.1 Report.2.1} {AddHelper B1.2 B2.2 Report.2.2}}

        else
            {AddHelper 0|B1 0|B2 Report}
        end
        
    end
    
end
 


%{Browse {Add [1 1 0 1 1 0] [0 1 0 1 1 1]}}

%éxécuter une ligne à la fois

%{Browse {Add [1 1 0 1] [1 0 0 1]}}



%-----------------------Question 3 --------------------------------%


declare
fun{Average L}
    fun{AverageAcc L S N}
        case L
        of nil then S / N
        [] H|T then {AverageAcc T H+S N+1.}
        end
    end
in
    {AverageAcc L 0. 0.}
end

%{Browse {Average [42. 17. 25. 61. 9.]}}


declare
fun{Var L}
    fun{VarAcc L Ssquared Snormal N}
        case L
        of nil then (Ssquared/N +(~ (Snormal/N)*(Snormal/N)))
        [] H|T then {VarAcc T (Ssquared + H*H) (Snormal + H) N+1.}
        end
    end
in
    {VarAcc L 0. 0. 0.}
end

%{Browse {Var [42. 17. 25. 61. 9.]}}




% ------------------------- Question 4 -----------------------%

declare 
fun {Fact N}
    fun {FactAux N Acc}
        if N == 1 then 1|Acc
        else {FactAux N-1 {Helper N 1}|Acc}
        end 
    end

    fun {Helper N C}
        if N == 1 then C
        else
            {Helper N-1 C*N}
        end
    end

in
    {FactAux N nil}
end

%{Browse {Fact 4}} % affiche [1 2 6 24]


%-------------PROGRAMMATION SUR LES ENREGISTREMENTS----------------------%

%------------------Question 1------------------%

