%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [yy] = smooth_fit(y,n,acc)
%
%Input: -y: Spectre initial sur lequel ont veut estimer le background
%       -n: Nombre de feature qui seront moyennée à chaque ittération. Plus
%       n est grand plus l'estimation du background sera grossière. Plus n
%       sera petit plus l'estimation sera proche du spectre. 
%       acc: C'est le facteur d'erreur accepter entre chaque ittération.
%       Plus acc est petit plus l'algorithme aura tendance à amplifier les
%       différent pic du spectre. 
%
%Output: yy: Estimation du background
%
%Description: L'algorithme utilise la fonction smooth qui permet de faire
%la moyenne sur n feature d'un spectre. À chaque ittération on estime le
%background en appliquant smooth(spectre,n) qui est l'équivalent d'un
%filtre passe bas sur le spectre. On regarde ensuite quels feature dépasse
%un certain treshold par entre le spectre et l'estimation du background.
%Les features qui dépassent le treshold sont affectées à la valeur du
%backgorund estimer pour la prochaine ittération. Le treshold est défini à
%partir de la variable acc et de L'écart standard du spectre. Lorsqu'il n'y
%a plus aucun feature qui dépasse le treshold alors l'algorithme s'arrête. 
%
%Auteur: Karl St-Arnaud, le 01-10-2015
%Modifié le, 03-05-2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [yy] = smooth_fit(y,n,acc)

y = y(:);
yy = smooth(smooth(y,n),n); %Première estimation du background
stand = std(y);% Calcule de la déviation standard du spectre original
A = 1; %constante d'arrêt de l'algorithme
ittmax = 30; %Nombre d'itération maximale permis
itt = 1; %Ittérateur

while A == 1
     v = y>yy+(acc*stand); %Vérifie les features de y qui sont plus que l'estimation du background plus une composant dépendant de l'erreur permise
     y(v==1) = yy(v==1); %Les valeurs qui sont en dehors de l'intervalle sont remplacé par l'estimation du background pour la prochaine itération
     if ~any(v) %Si aucune valeur n'est modifié alors l'algorithme s'arrête.
         A = 2;
     else
         yy = smooth(y,n); %Application du filtre passe bas pour l'ittération suivante
         A = 1;
     end
    stand = std(y); %Estimation de la nouvelle écart-standard
    itt =itt+1;
    if itt>ittmax
        A = 2;
    end
end

 
            