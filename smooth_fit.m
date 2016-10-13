%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [yy] = smooth_fit(y,n,acc)
%
%Input: -y: Spectre initial sur lequel ont veut estimer le background
%       -n: Nombre de feature qui seront moyenn�e � chaque itt�ration. Plus
%       n est grand plus l'estimation du background sera grossi�re. Plus n
%       sera petit plus l'estimation sera proche du spectre. 
%       acc: C'est le facteur d'erreur accepter entre chaque itt�ration.
%       Plus acc est petit plus l'algorithme aura tendance � amplifier les
%       diff�rent pic du spectre. 
%
%Output: yy: Estimation du background
%
%Description: L'algorithme utilise la fonction smooth qui permet de faire
%la moyenne sur n feature d'un spectre. � chaque itt�ration on estime le
%background en appliquant smooth(spectre,n) qui est l'�quivalent d'un
%filtre passe bas sur le spectre. On regarde ensuite quels feature d�passe
%un certain treshold par entre le spectre et l'estimation du background.
%Les features qui d�passent le treshold sont affect�es � la valeur du
%backgorund estimer pour la prochaine itt�ration. Le treshold est d�fini �
%partir de la variable acc et de L'�cart standard du spectre. Lorsqu'il n'y
%a plus aucun feature qui d�passe le treshold alors l'algorithme s'arr�te. 
%
%Auteur: Karl St-Arnaud, le 01-10-2015
%Modifi� le, 03-05-2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [yy] = smooth_fit(y,n,acc)

y = y(:);
yy = smooth(smooth(y,n),n); %Premi�re estimation du background
stand = std(y);% Calcule de la d�viation standard du spectre original
A = 1; %constante d'arr�t de l'algorithme
ittmax = 30; %Nombre d'it�ration maximale permis
itt = 1; %Itt�rateur

while A == 1
     v = y>yy+(acc*stand); %V�rifie les features de y qui sont plus que l'estimation du background plus une composant d�pendant de l'erreur permise
     y(v==1) = yy(v==1); %Les valeurs qui sont en dehors de l'intervalle sont remplac� par l'estimation du background pour la prochaine it�ration
     if ~any(v) %Si aucune valeur n'est modifi� alors l'algorithme s'arr�te.
         A = 2;
     else
         yy = smooth(y,n); %Application du filtre passe bas pour l'itt�ration suivante
         A = 1;
     end
    stand = std(y); %Estimation de la nouvelle �cart-standard
    itt =itt+1;
    if itt>ittmax
        A = 2;
    end
end

 
            