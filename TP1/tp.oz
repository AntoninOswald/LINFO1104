declare 
fun {Fact1 N}
    if N == 0 then 1 else N*{Fact1 N-1} end
end

% La seconde partie prend moins de mémoire


declare 
fun {FactAux N Acc}
    if N =< 1 then Acc else {FactAux N-1 Acc*N} end % Concept des 
                                                    % vases communiquants
end

fun {Fact N}
    {FactAux N 1}
end

%{Browse {Fact 4}}


declare
fun {Sum N}
    if N == 1 then 1 else ((N*N) + {Sum N-1}) end
end

declare
fun {SumAcc N Acc}
    if N==0 then Acc else {SumAcc N-1 Acc+N*N}end 
end

% Ici le Acc doit être initialiser à 0


%{Browse {SumAcc 6 0}}

declare
fun {MirrorAcc N Acc}
    if N > 0 then {MirrorAcc (N div 10) ((Acc*10) + (N mod 10))} else Acc end % https://www.geeksforgeeks.org/write-a-program-to-reverse-digits-of-a-number/
end

declare
fun {Mirror N}
    {MirrorAcc N 0}
end


%{Browse {Mirror 54321}}




% Partie 2 Question 3

declare
fun {Foo N}
    if N<10 then 1
    else 1+{Foo (N div 10)}
    end
end




%Partie 2 Question 4


declare
local
    fun {FooHelper N Acc}
        if N<10 then Acc+1
        else {FooHelper (N div 10) (Acc+1)}
        end
    end
in
    fun {Foo N}
        {FooHelper N 0}
    end
end


%%{Browse {Foo 0-123}} % Ici le code fonctionne, et avec un accumulateur, il consomme
                    % moins de mémoire.


% Partie 2 question 5 On donne un exemple de procédure

declare 
proc {BrowseNumber N}
    {Browse N}
    {Browse N+1}
end

%{BrowseNumber 12}


% Faire un countdown


declare 
proc {Countdown N}

    {Browse N}
    if (N-1) > (0-1) then {Countdown N-1} end

end






% Il est intéressant de noter que quand on lance plusieurs Browse ou proc en
% même temps, les résultats ne s'affichent pas nécessairement dans l'ordre
% du code 


% ----------------------------------------------------------------------------------%

% exo supplementaire


% Question 1 - Test primalite // On peut faire aussi une version avec local in

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
    {PremierAux 2 N-1 N}
end





declare
local 
    fun {PremierHelper M K N} 
        if (K*K) > N then {PremierHelper M K-1 N} 
            else
            
            if K == M-1 then true
            else
                if ((N mod K) == 0) then false
                else {PremierAux M K-1 N }
                end
            end
        end
        
    end
    
    in
        fun {Premierloc N}
            {PremierHelper 2 N-1 N}
        end
    
end


% Question 2 Fibonnacci1

% Pour n = 1, 1 appel. Pour n = 4, 9 appels. Pour n = 5, 15 appels.
% Pour n, on trouve un nombre d'appel equivalent à 2n-1 --> Algo en O(n)

% Question 3 
declare 
local 
    fun {FibHelper N Acc1 Acc2}   % Ici le double accumulateur nous permet de garder en mémoire

        if N==1 then % jusqu'à n-2, car fib(n) = fib(n-1) + fib(n-2)
            Acc1 
        else {FibHelper N-1 (Acc1 + Acc2) Acc1} % Quand on fait n-1 en global, on doit mettre dans les accumulateurs la valeur du n-1, qui disparait sinon
            % En effet, le n-2 est toujours compris dans la récursion
        end 

        % fib(n) = f(n-1) + f(n-2) --> F(n-1) = f(n-2) + f(n-3)


    end
    
    in

        fun {Fib N}

            if N==0 then
                0
            else

            {FibHelper N 1 0}
            end
            
        end

    
end


% Question 4

declare 
fun {PGCD M N}
    if N == 0 then M
    else {PGCD  N (M mod N )  } end
end



declare 
fun {PPCM M N} % On trouve que PPCM*PGCD = M*N
    
    (M*N) div {PGCD M N}

end




% Question 5 

declare 
fun {Summer N Acc}
    if N==0 then
        Acc
    else {Summer N-1 Acc+N+1} 
    end
end

local Sum Counter X Y Aux in
    fun {Numero X Y}

        

        Sum = X+Y
        Counter = {Summer Sum-1 0} + Y + 1

        Counter
    
    end
end




 % Question 6 (On regarde tous les diviseurs sans reste de la longueur du carré)

 

local 
    fun {PavageHelper N X Acc} 
        if X == 0 then Acc 
        else
            if (N mod X == 0) then {PavageHelper N X-1 Acc+1}
            else
                {PavageHelper N X-1 Acc}
            end
        end
    end

    in
    fun {NombrePavages N}
        {PavageHelper N N 0}
    end
end


    
{Browse {NombrePavages 6}}


local 
    fun {Sommeur N X Acc} %On fait la somme des carrés 1 + 2*2 + 3*3 + 6*6 (chaque diviseur)
         if X == 0 then Acc 
         else
            if (N mod X == 0 ) then {Sommeur N X-1 (Acc + X*X)}
            else {Sommeur N X-1 Acc}
            end
        end
    
    end  
    
    in
        fun {NombrePave N}
            {Sommeur N N 0}
        end
    

    
end


{Browse {NombrePave 6}}




            





