%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function[xx,yy,y]=fluo_mod1(x,y)
%Output
%       -xx: Axe des x du spectres Raman données en cm^{-1}
%       -yy: Axe des y du spectres Raman données en unité relative 
%            (maximum 1)
%       -y: Spectres d'auto-fluorescence qui a été soustrait au spectres 
%           données aussi en unité relative (maximum 1)
%Input
%       -x: Vecteur de (1:1024) [!!!!Attention toujours utilisé x=1:1024!!!!] même longueur que le vecteur initiale du
%           spectres raman recueillie
%       -y: Vecteur de (1:1024) correspondant au spectres Raman sans
%           prétraitement 
%
%Cette fonction prend en entrée le spectres Raman sans prétraitement. Elle
%permet de soustraire l'auto-fluorescence en performant un polyfit d'ordre
%6. Pour optimiser le rapport signal sur bruit une éthode itérative est
%utilisé permettant de soustraire les pics du polyfit. Ensuite un filtre
%Gaussien est utilisé pour éliminer le bruit du spectre. La fonction
%polyfit a été réécrite "poly_fit" fonction optimiser pour réduire le temps
%calcul de la fonction
%
%Karl St-Arnaud
%09-07-2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[yy,y]=fluo_mod1(x,y)

x = x(:);
y = y(:);
% figure()
%mémoire des spectres initiales
x_o=x;
y_o=y;

%création du premier polyfit
c = poly_fit(x,y);
p = polyval(c,x);
R = y-p;
DEV = std(R);
% plot(x,y);
% hold all
% plot(x,p);
%première itération
v=y<p+(DEV/16);
v(1) = 1;
n_x=x(v==1);
n_y=y(v==1);

%création du deuxième polyfit
c = poly_fit(n_x,n_y);
p = polyval(c,n_x);
% plot(n_x,p);
R = n_y-p;
DEV = std(R);

%Deuxième itération
vv=n_y<p+(DEV/16);
vv(1) = 1;
nn_x=n_x(vv==1);
nn_y=n_y(vv==1);

%Polyfit finale et normalisation
c=poly_fit(nn_x,nn_y);
y = polyval(c,x_o);
% plot(x_o,y);
yy=(y_o-y);

