




%-----------------Exercice1----------------------------%

%atom = truc en minuscule https://www.info.ucl.ac.be/~pvr/ds/FSAB1402/syntax.html
declare 
L1=[a] 
L2=[a [b c] d] 
L3=[proc {$} {Browse oui} end proc {$} {Browse non} end] 
L4=[est une liste] 
L5=[[a p]]

% Dans l'autre sens

declare
L6 = a|nil
L7 = a| (b|c|nil)|d|nil
L8 = proc {$} {Browse oui} end| proc {$} {Browse non} end | nil
L9 = est|une|liste|nil
L10 = (a|p|nil)|nil

%Rajouter ceci

Lceci = ceci|L4

% appeler des éléments d'une liste de procédure

%{L3.1}
%{L3.2.1} %Ici pour avoir "non", il faut bien préciser qu'on prend le HEAD et non le TAIL du second element

% Reduire L2

L2reduced = L2.2 %On prend la tail

% Func Head and Tail

declare 
fun {Head L}
    L.1
end

declare 
fun {Tail L}
    L.2
end

%{Browse {Head [a b c]}} % affiche a
%{Browse {Tail [a b c]}} % affiche [b c]



%----------------------------Question2-----------------------------%


%On peut utiliser le pattern matching (voir slide 37-39) + recursion terminale 
%Invariant Len(L) = Acc + Len(A) ou A est la sublist où on se trouve et L la liste initiale
%On aurait pu également utiliser L.1 et L.2 (voir suite)
declare 
local
    fun {LengthHelper L Acc}
        case L
        of nil then Acc
        [] H|T then {LengthHelper T Acc+1}    %En raisonnant de la sorte, on ne doit pas se soucier
                                              % des éventuelles sous-listes
            
        end
    end 
 in
    fun {Length L}
        {LengthHelper L 0}
    end
end


%{Browse {Length [r a p h]}} % affiche 4
%{Browse {Length [[b o r] i s]}} % affiche 3
%{Browse {Length [[l u i s]]}} % affiche 1


%version avec L.1/2

declare 
local
    fun {LengthHelper2 L Acc}
        
        if L.2 == nil then Acc+1 else {LengthHelper2 L.2 Acc+1}
        end
            
        
    end 
 in
    fun {Length2 L}
        {LengthHelper2 L 0}
    end
end


%{Browse {Length2 [r a p h]}} % affiche 4
%{Browse {Length2 [[b o r] i s]}} % affiche 3
%{Browse {Length2 [[l u i s]]}} % affiche 1


%------------------Question 3 --------------------------------%



declare
fun {Append A B}
    case A
    of nil then B 
    [] H|T then H|{Append T B}
    end
end


%{Browse {Append [r a] [p h]}} % affiche [r a p h]
%{Browse {Append [b [o r]] [i s]}} % affiche [b [o r] i s]
%{Browse {Append nil [l u i s]}} % affiche [l u i s]







%---------------------Question 4 ---------------------------------%


%Premier point

declare
fun {Func L}
    case L
    of nil then empty
    [] H|T then nonEmpty
    else other

    end
end

% Second point --> Voir directement dans les questions precedentes


declare 
fun {Head L}
    case L
    of H|T then
        H
    end
end

declare 
fun {Tail L}
    case L
    of H|T then
        T
    end
end



%-----------------------------Question5--------------------------------------------%


declare 
fun {Take Xs N}
    if N==0 then nil
    else
        case Xs
        of H|T then H|{Take T N-1}
        [] nil then nil
        end
    end
 
end

%{Browse {Take [r a p h] 2}} % affiche [r a]
%{Browse {Take [r a p h] 7}} % affiche [r a p h]
%{Browse {Take [r [a p] h] 2}} % quel est le resultat


declare 
fun {Drop Xs N}
    if N == 0 then Xs
    else
        case Xs
        of H|T then {Drop T N-1}
        else Xs
        end
    end

end


%{Browse {Drop [r a p h] 2}} % affiche [p h]
%{Browse {Drop [r a p h] 7}} % affiche nil
%{Browse {Drop [r [a p] h] 2}} % quel est le resultat



%----------------------------------Question6--------------------------------%


declare 
local
    fun {Helper L Acc}
        case L
        of nil then
            Acc
        [] H|T then
            {Helper T Acc*H} 
        end
    end 
in
    fun {MultList L}
        {Helper L 1}
    end
end


{Browse {MultList [1 2 3 4]}} % affiche 24



%-------------------------Question7-------------------------------%

A = [1 2 3]

B = [4 5 6]

Comp = A|B|nil

%-----------------------------Question8----------------------------%

%Solution récupérée dans ce document
%https://uclouvain-my.sharepoint.com/personal/miguel_delecourt_student_uclouvain_be/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fmiguel%5Fdelecourt%5Fstudent%5Fuclouvain%5Fbe%2FDocuments%2FEPL%2DDrive%2FBACHELIER%2FINFO%2FQ4%2FLINFO1104%20%2D%20Paradigmes%20de%20programmation%20et%20concurrence%2Fanciens%20cours%20%28oz1%2C%20oz2%20des%20q3%2Dq6%29%20donn%C3%A9s%20jusqu%27en%202020%2FLFSAB1402%20%2D%20Informatique%2FAPE%2FAPE%5Fq3%5Finfo%2DFSAB1402%2DSol%2Epdf&parent=%2Fpersonal%2Fmiguel%5Fdelecourt%5Fstudent%5Fuclouvain%5Fbe%2FDocuments%2FEPL%2DDrive%2FBACHELIER%2FINFO%2FQ4%2FLINFO1104%20%2D%20Paradigmes%20de%20programmation%20et%20concurrence%2Fanciens%20cours%20%28oz1%2C%20oz2%20des%20q3%2Dq6%29%20donn%C3%A9s%20jusqu%27en%202020%2FLFSAB1402%20%2D%20Informatique%2FAPE

declare
fun { Prefix L1 L2 }
    case L1 # L2 of nil # M then true %Cas où on a parcouru tout le prefixe sans renvoyer de false
    [] M # nil then false %On a fini la liste sans finir le prefixe
    []( H1 | T1 ) #( H2 | T2 ) then %Les deux ont encore des éléments qui suivent
        if H1 == H2 then { Prefix T1 T2 } %reccursion si les deux liste on la même head
        else false
        end
    end
 end

fun { FindString L1 L2 }
    fun { FindStringAux L Pos } %Cette implementation nous permet de definir L1 pour toute la fonction auxillaire
        case L of nil then nil %On a fini de parcourir la liste
        [] H | T then
            if { Prefix L1 L } then Pos |{ FindStringAux T Pos +1}
            else { FindStringAux T Pos +1}
            end
        end
    end
in
    { FindStringAux L2 1}
end







%{Browse {FindString [a b a b] [a b a b a b]}} % affiche [1 3]
%{Browse {FindString [a] [a b a b a b]}} % affiche [1 3 5]
%{Browse {FindString [c] [a b a b a b]}} % affiche nil


%-------------------------Question 9 -------------------------------------%
 
declare
Carte = carte(menu(entree: 'salade verte aux lardons'
                    plat: 'steak frites'
                    prix: 10)
              menu(entree: 'salade de crevettes grises'
                   plat: 'saumon fume et pommes de terre'
                   prix: 12)
              menu(plat: 'choucroute garnie'
              prix: 9)) 


%  Second menu = crevettes grise --> Carte.2

% plat second menu = Carte.2.plat | entrée premier menu = Carte.1.entree

% N1*Carte.1.prix N2*Carte.2.prix + N3*Carte.3.prix = prix total

% Pour rappel, arité = Liste lexicographique ordered des fields du record

%{Browse {Arity Carte.1}} % [1 2 3] pour Carte et pour chaque menu [entree plat prix]


%----------------------------------Question 10 ----------------------------------------%



%<btree T> ::= empty | btree(T left:<btree T> right:<btree T> définition de l'arbre binaire

declare 
MyBinaryTree = btree(42 
                    left: btree(26
                                left: btree(54
                                            left: empty
                                            right: btree(18
                                                         left: empty
                                                        right: empty))
                                right: empty)
                    right: btree(37
                                left: btree(11
                                            left: empty
                                            right: empty)
                                right: empty))



declare 
fun {Promenade BT}
    fun {Helper T Acc}
        case T 
        of empty then Acc
        [] btree(Node left:L right:R) then Node|{Append {Helper L nil} {Helper R nil}}
        end
        % On parcourt d'abord le node (d'ou le Node|...) et puis on continue la liste
        %en visitant les sous-arbres et en les ajoutants à la fin.
        %On visite d'abord à gauche et puis à droite, donc on ajoute 
        %la liste associée à L et puis celle associée à R

        
    end


in 
    {Helper BT nil}
end


            
%{Browse {Promenade MyBinaryTree}} %% affiche [42 26 54 18 37 11] --> Sum = 188


% On peut utiliser la fonction FoldL dont la spe est donnée http://mozart2.org/mozart-v1/doc-1.4.0/base/list.html

% On definit d'abord la fonction sum, qu'on peut faire en interne.

declare
Sum = {FoldL {Promenade MyBinaryTree} fun {$ X Y} X+Y end 0} %Dans la spécification, on voit que le dernier champ
                                                             % est l'accumulateur. Il doit être =0 car c'est une addition


%{Browse Sum} --> Donne bien le bon resultat


declare 
fun {PromenadeAdditive BT}
    fun {Helper T Acc}
        case T 
        of empty then Acc
        [] btree(Node left:L right:R) then (Node + ({Helper L 0} + {Helper R 0}))
        end
        % Ne pas oublier de réinitialiser l'accumulateur à 0 dès qu'on va dans un
        %nouvel arbre
        
    end

in 
    {Helper BT 0}
end


%{Browse {PromenadeAdditive MyBinaryTree}} % affiche 188


%-----------------------------------------Question 11-----------------------------------%



%dico vide --> atome leaf
%dico non-vide : dict(key:Key info:Info left:Left right:Right)


fun {DictionaryFilter D F}
    
    fun {Helper T Acc}
        case T
        of leaf then Acc
        [] dict(key:K info:person(Name Age) left:L right:R) then 
            (K#person(Name Age))|{Append {Helper L nil} {Helper R nil}} %Même mécanique qu'avant.
                
        end
        
    end

    



    fun {Filtrer List F}
        case List
        of nil then nil
        [] H|T then
            if {F H.2} then H|{Filtrer T F}
            else {Filtrer T F} end
        end
    end
            
in
        
    {Filtrer {Helper D nil} F} %La fonction Helper nous donne une liste qui représente les
    %Valeurs de l'arbre. Ensuite on appliquer Filtrer, qui nous donne la liste Filtrée
    
        
end



local Old Class Val in

        %Lorsqu'on Browse cela, on obtient une mise en page automatique
    Class = dict(key:10 
        info:person('Christian' 19)
        left:dict(key:7
        info:person('Denys' 25)
        left:leaf
        right:dict(key:9
            info:person('David' 7)
            left:leaf
            right:leaf))
        right:dict(key:18
        info:person('Rose' 12)
        left:dict(key:14
        info:person('Ann' 27)
        left:leaf
        right:leaf)
        right:leaf))

    fun {Old Info}
            Info.2 >20
    end

    Val = {DictionaryFilter Class Old}

    %{Browse Val}

end




%------------------------------Question 12 ---------------------------------------------%



% Il existe les fonctions IsList et IsTuple

%'|'(a b) tuple uniquement
%'|'(a '|'(b nil)) Liste et tuple
%'|'(2:nil a) Liste et tuple


% state(1 a 2) tuple uniquement
%state(1 3:2 2:a) tuple uniquement
%tree(v:a T1 T2) Aucun des deux

% a#b#c Juste un tuple
%[a b c] Liste et tuple
%m|n|o Uniquement un tuple

%-----------------------------Question 13 %-----------------------%


fun {Applique L F}  % = function map
    case L
        of nil then nil
        [] H|T then {F H}|{Applique T F}
    end

end
        

declare
fun {Lol X} 
    lol(X) 
end
%{Browse {Applique [1 2 3] Lol}} % Affiche [lol(1) lol(2) lol(3)]

%Pour le second point, on peut retrouver des explications sur
%StackOverflow https://stackoverflow.com/questions/18797813/returning-a-function-from-a-function-in-oz-higher-order-problems
declare
fun {MakeAdder N}
    fun{$ B} N+B end
end
%Il fallait utiliser le mot clé $



declare
Add5 = {MakeAdder 5}

{Browse {Add5 13}} % Affiche 18


% Combiner Applique et MakeAdder


fun {AddAll L N}

    {Applique L {MakeAdder N}} %MakeAdder renvoie une fonction comme demandé

    
end

%{Browse {AddAll [1 2 3] 3}}



%------------------------------Question14----------------------------%


{Browse {Label a#b#c}} %Affiche le "type" du tuple, ici le #
{Browse {Width un#tres#long#tuple#tres#tres#long}} % Le nombre d'éléments (le nombre de champs du tuple)
{Browse {Arity 1#4#16}} % Arité = liste des champs. Ici, quand ils ne sont pas nommés explicitement, c'est directement [1 2 3]


fun {SameLength Xs Ys}
    case Xs#Ys
    of nil#nil then true
    [] (X|Xr)#(Y|Yr) then {SameLength Xr Yr}
    else false
    end
end

%Dans cette fonction on crée un tuple afin de pouvoir analyser de manière parallèle
% Le fonctionnement de ces fonctions. ça nous évite des boucles if




    











