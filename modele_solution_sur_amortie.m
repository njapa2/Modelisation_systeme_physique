% Paramètres du circuit  
L = 3; % Inductance en Henry  
C = 10*10^-1; % Capacité en Farads  
R = 10*10^3;   % Résistance en Ohms  
E = 1;    % Amplitude de la tension d'entrée (V)
% Tension délivrée : e = Ecos(wt)
w = 0.0001;
%
wd = sqrt(((4*L)/C)-(R^2/(2*L)));
B = (R*E*C^2*w^2*(1-L*C*w^2))/((1-L*C*w^2)*((-L*w^2+L^2*C*w^4+R^2*w^2*C)*C+1-L*C*w^2));
A = ((-E*w+R*B*w)*C)/(1-L*C*w^2);
r1=(-R+sqrt(R^2-4*L/C))/(2*L);
r2=(-R-sqrt(R^2-4*L/C))/(2*L);
A1 = (r2*B-A*w)/(r1-r2);
B1 = (r1*B-A*w)/(r2-r1);
t=linspace(0,10,100);
% Solution particulière :
ip = A*sin(w*t) + B*cos(w*t);
% Solution homogène :
ih = A1*exp(r1*t)+B1*exp(r2*t);
% Solution gnérale : 
i = ip + ih;
% Tracé de la solution :
figure(1);
plot(t,i,'linewidth',2);
xlabel('Temps t(en s)');
ylabel('Intensité i (en A)');
title('Tracé de la solution analytique (système sur-amorti)');
grid on;
