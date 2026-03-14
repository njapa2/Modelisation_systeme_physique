% Paramètres du circuit  
L = 30; % Inductance en Henry  
C = 10*10^-1; % Capacité en Farads  
R = 10;   % Résistance en Ohms  
E = 1;    % Amplitude de la tension d'entrée (V)
% Tension délivrée : e = Ecos(wt)
w = 0.0001;
%
wd = sqrt(((4*L)/C)-(R^2/(2*L)));
B = (R*E*C^2*w^2*(1-L*C*w^2))/((1-L*C*w^2)*((-L*w^2+L^2*C*w^4+R^2*w^2*C)*C+1-L*C*w^2));
A = ((-E*w+R*B*w)*C)/(1-L*C*w^2);
A1 = -B;
B1 = ((-R*B)/(2*L*wd))-((A*w)/wd);
t=linspace(0,10,1000);
% Solution particulière :
ip = A*sin(w*t) + B*cos(w*t);
% Solution homogène :
ih = exp(-R*t/(2*L)).*(A1*cos(wd*t)+B1*sin(wd*t));
% Solution gnérale : 
i = ip + ih;
% Tracé de la solution :
figure(1);
plot(t,i,'r','linewidth',2);
xlabel('Temps t(en s)');
ylabel('Intensité i (en A)');
title('Tracé de la solution analytique (système sous-amorti)');
hold on;
plot(t,i,'o', 'MarkerSize', 2, 'MarkerEdgeColor', 'b');
xlabel('Temps t(en s)');
ylabel('Intensité i (en A)');
title('Tracé de la solution analytique et numérique (système sous-amorti)');
grid on;
