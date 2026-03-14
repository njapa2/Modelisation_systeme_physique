% Paramètres (à définir)
L = 3;       % Inductance
R = 10000;       % Résistance
C = 1;       % Capacité
E = 1;       % Amplitude de la force
% Gamme de fréquences (en rad/s)
w_min = log10(0.1);
w_max = log10(100);
w_vals = logspace(w_min, w_max, 50);  % 50 points

% Préallocation du vecteur amplitude
amplitudes = zeros(size(w_vals));

% Conditions initiales
x1_0 = 0;  % valeur initiale
x2_0 = 0;
y0 = [x1_0; x2_0];

% Temps de simulation
t_final = 100;       % durée pour atteindre régime stationnaire
dt = 0.01;           % pas de temps
t = 0:dt:t_final;

for i = 1:length(w_vals)
    w = w_vals(i);  % fréquence courante
    
    % Définir la fonction système comme une fonction anonyme utilisant w
    sys = @(t, y) [ y(2); (1/L)*(-R*y(2) - (1/C)*y(1) - E*sin(w*t)) ];
    
    % Résolution numérique
    [T, Y] = ode45(sys, t, y0);
    
    % Extraire la réponse x(t)
    x_t = Y(:,1);
    
    % Calcul de l'amplitude dans la dernière période
    period_points = round(2*pi/w / dt);  % nombre de points dans une période
    if length(x_t) < period_points
        period_points = length(x_t);  % si pas assez de points
    end
    x_final_segment = x_t(end - period_points + 1 : end);
    
    % Amplitude (moitié de la différence max-min)
    amplitude = (max(x_final_segment) - min(x_final_segment))/2;
    amplitudes(i) = amplitude;
end

% Tracé du diagramme amplitude vs fréquence (échelle logarithmique)
figure;
semilogx(w_vals, amplitudes, '-o');
xlabel('Fréquence (rad/s)');
ylabel('Amplitude');
title('Réponse en fréquence du système');
grid on;
