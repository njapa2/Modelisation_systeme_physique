import numpy as np
import matplotlib.pyplot as plt
import math
# Paramètres (à ajuster selon ton problème)
L = 3  # Inductance
R = 10000  # Résistance
C = 1  # Capacité
E = 1  # Amplitude de la force extérieure
w = 0.0001  # Fréquence de la force extérieure
# tension delivree e(t) = Ecos(wt)
B=(R*E*C*C*w*w*(1-L*C*w*w))/((1-L*C*w*w)*((-L*w*w+L*L*C*w*w*w*w+R*R*w*w*C)*C+1-L*C*w*w))
A = ((-E*w+R*B*w)*C)/(1-L*C*w*w)
r1=(-R+math.sqrt(R*R-4*L/C))/(2*L)
r2=(-R-math.sqrt(R*R-4*L/C))/(2*L)
A1 = (r2*B-A*w)/(r1-r2)
B1 = (r1*B-A*w)/(r2-r1)

# Intervalle de temps
t0 = 0
tf = 10  # Temps final
dt = 0.001  # Pas de temps
t = np.arange(t0, tf + dt, dt)

# Solution particulière :
ip = A*np.sin(w*t) + B*np.cos(w*t)
# Solution homogène :
ih = A1*np.exp(r1*t)+B1*np.exp(r2*t)
# Solution générale : 
i = ip + ih;
# Tracé de la solution :
plt.plot(t,i);
plt.xlabel('Temps t(en s)')
plt.ylabel('Intensité i (en A)')
plt.title('Tracé de la solution analytique (système sur-amorti)')
