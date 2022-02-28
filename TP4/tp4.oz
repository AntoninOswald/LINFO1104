

%----------------------Question 2 ---------------------%


declare 
fun {MakeMulFilter N}
    fun {$ I}
        if (I mod N) == 0 then
            true
        else 
            false
        end
    end

end

declare 
A = {MakeMulFilter 6}

%{Browse {A 13}}



declare 
fun {Filter L F}
    
    case L of nil then nil
    [] H|T then
        if {F H} == true then H|{Filter T F}
        else 
            {Filter T F}
        end
    end

end


declare 
List1 = [10 2 3]

%{Browse {Filter List1 {MakeMulFilter 2}}}
%{Browse {Filter List1 {MakeMulFilter 3}}}





declare 
fun {PremierAux M K N}
    if K == M-1 then true
    else
        if ((N mod K) == 0) then false
        else {PremierAux M K-1 N }
        end
    end
end

declare 
fun {Premier N}
    if N == 1 then
        true
    else
        {PremierAux 2 N-1 N}
    end
    
end

%{Browse {Filter List1 Premier}}


%-----------------------------Question 3 ---------------------------%

%D'abord on crée une fonction compose qui nous
%permet de simplifier la procédure quand on
%rajoute une fonction


declare 
fun {Compose F G}
    fun{$ X} {F {G X}} end
end

declare 
fun {MultList List}
    if List == nil then nil
    else
        {FoldL List fun{$ X Y} X*Y end 1}
    end

end


%{Browse {MultList List1}}


declare 
fun {SubList List}
    if List == nil then
        nil
    else
        {FoldL List fun{$ X Y} X-Y end 0}
    end
    
end

    
%{Browse {SubList List1}}



%------------------- Question 4---------------------------%



fun {Applique L F}  % = function map
    case L
        of nil then nil
        [] H|T then {F H}|{Applique T F}
    end

end


%on peut renvoyer une fonction anonyme en choissant d'abord 
%l'exposant qu'on souhaite utiliser

fun {PoweringList E}
    fun {$ N}
        {Pow N E}
    end
end
        
%{Browse {Applique List1 {PoweringList 2}}}

%---------------------Question 5 ------------------------------%

%on peut faire une fonction qui calcule un convertisseur
%spécifique à l'aide d'un convertisseur anonyme






fun {Convertir T V}
    T*V
end


fun {ConvMaker T}
    fun {$ V}
        {Convertir T V}
    end
end


%Faire un conv maker nous permet de créer une autre instance
%à chaque taux nécessaire


ToMiles = {ConvMaker 0.8}

%{Browse {ToMiles 30.0}}

%Sous-question 2

%Le truc ici est d'utiliser une liste quand on a plusieurs coefficients
%et un chiffre quand on a juste un facteur multiplicatif
%On peut rajouter des cas à chaque fois, si par exemple on a besoin
%de quelque chose de quadratique,... [A B C] then A*V*V + B*V + C, etc...


fun {ConvComplex T V}
    case T

    of [A B] then
        A*V + B

    [] A then 
        A*V

    end
end

fun {ConvMaker2 T}
    fun {$ V}
        
        {ConvComplex T V}
    end
end


%{Browse {ConvComplex [1 2] 11}} %affiche 13 11*1 +2

FarToCelsius = {ConvMaker2  [0.56 ~17.78]} %~

%{Browse {FarToCelsius 132.8}}

%{Browse 2}


%-------------------Question 6 ---------------------------------------%

%Soit on utilise cette formule pour calculer la somme des carrés des nombres impairs de 0 à n

fun {SumSquare N}
    fun{SumSquareAux N Acc}
        if N =< 0 then Acc
        elseif N mod 2 == 0 then {SumSquareAux N-1 Acc}
        else {SumSquareAux N-1 Acc + (N*N)} end
        end
in
    {SumSquareAux N 0}
end


%Mais l'exercice nous demande d'utiliser la programmation fonctionnelle 

%Il nous reste à implémenter les fonctions utilisées pour P1,2,3

%rendre terminal récursif ?

fun {GenerateList N}
    fun {Aux N Max}

        if N == Max+1  then
            nil
        else
           N|{Aux N+1 Max}
        end
        
    end

in
    {Aux 0 N}

end




La = {GenerateList 9}

%{Browse La}

fun {MyFilterbis List Func} %Renvoie la liste en arrière. ça n'a pas d'important quand on 
    %fold mais si l'application nécessite une priorité des opérations, il vaut mieux
    %utiliser celle qui renvoie dans l'ordre

    fun {Aux List Func Acc}
        case List
        of nil then
            Acc
        [] H|T then 
            if {Func H} == true then {Aux T Func H|Acc}
            else 
                {Aux T Func Acc}
            end
        end
    end
    
in
    {Aux List Func nil}

end



fun {MyFilter List Func}
    
    case List
    of nil then nil
    [] H|T then 
        if {Func H} == true then 
            H|{MyFilter T Func}
        else
            {MyFilter T Func}
        end
    end
end


FLa = {MyFilter La fun {$ X} X mod 2 \= 0 end}


%{Browse FLa}


fun {MyMapEasy List Func}
    {Map List Func} %Il y a déjà une fonction dans oz qui map
    %Il y en a une aussi qui filtre
end

%L'implémentation est assez facile
fun {MyMap List Func}
    case List of nil then nil
    [] H|T then
        {Func H}|{MyMap T Func}
    end
end


FMLa = {MyMap FLa fun {$ X} X*X end}

%{Browse FMLa}

%existante dans le module List de Oz
fun {MyFoldL2 List Func Acc}
    {FoldL List Func Acc}
end

%implémentation complète
fun {MyFoldL List Func Acc}
    case List of nil then Z
    [] H|T then {FoldL T Func {Func Acc H}}
    end
end


{Browse {MyFoldL FMLa fun {$ Acc X} X + Acc end 0}}


%-----------------------Question 7 --------------------%


local Y LB in
    Y=10
    proc {LB X ?Z}
        if X>=Y then Z=X
        else Z=Y end
    end

    local Y=15 Z in
        {LB 5 Z}
        {Browse Z}
    end
end

%Affiche 10, car le Y = 15 n'est pas le meme que celui
%définit dans le bloc d'au-dessus.

%Ce qu'il manque pour Kernel Language parfait :

%On aurait du définir Dix = 10 et Y = Dix

%Définir la variable true/false T = (X >= Y) et puis tester
%T de manière indépendante
