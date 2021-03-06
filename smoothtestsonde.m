%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [yy_fin,yy_fit2,yy] = smoothtest(yy,n,err)
%
%Input: -yy: Spectre initial auquel il faut soustraire le background
%       -n: Nombre de feature sur lequel le spectre sera moyenn� � chaque
%       itt�ration. Plus n est grand plus l'estimation du background sera
%       grossi�re. Cependant, plus n est petit plus on risque de perdre des
%       features important du spectre. La valeur de n d�pend du nombre de
%       feature dans le spectre. Pour 96 feature il est consseill�
%       d'utiliser n = 20. Pour 670 feature il est conseill� d'utiliser n =
%       60;
%       -err: C'est le crit�re d'arr�t de l'algorithme. � chaque itt�ration
%       l'algorithme v�rifie si la nouvelle estimation du background est
%       tr�s diff�rente de la nouvelle estimation. err est un scalaire qui
%       dicte le degr� de diff�rence accepter pour mettre fin �
%       l'algorithme. Plus err est petit plus on fait ressortir les pics
%       dans le spectres. Cependant, plus n est petit plus on risque
%       d'amplifier le bruit. Une valeur standard � utiliser est 0.05
%
%Output: -yy_fin: C'est le spectre final avec le background qui a �t�
%        retir� apr�s l'application d'un filtre permettant de retirer le
%        bruit
%        -yy_fit2: C'est l'estimation du background par l'algorithme
%        smooth_fit
%
%Descrip^tion: Cette fonction permet d'estimer le background d'un spectre
%Raman affect� par diff�rent art�fact spectral. La fonction utilise un
%filtre passe bas itt�ratif pour estimer le background. Voir la fonction
%smooth_fit pour plus de d�tail. Avant d'�tre envoy� � l'algorithme la
%fonction filtre d'abord le bruit pour emp�cher l'amplification de celui-ci
%par l'algorithme. Une fois le backgroung retir� du spectre un filtre est
%appliqu� pour retirer toute contribution du bruit restante. 
%
%Auteur: Karl St-Arnaud, le 01-10-2015
%modifi� le: 2016-06-03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [yy_fin,yy_fit2] = smoothtestsonde(yy,n,err)

yy = yy(:);
yy_fit2 = smooth_fit(yy,n,err); %Application de smoothfit retourne une estimation du background
yy_fin = yy-yy_fit2;

end