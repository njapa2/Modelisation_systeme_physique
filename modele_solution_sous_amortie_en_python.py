import numpy as np
import matplotlib.pyplot as plt
import math
# Paramètres du circuit  
L = 30; # Inductance en Henry  
C = 1; # Capacité en Farads  
R = 10;   # Résistance en Ohms  
E = 1;    # Amplitude de la tension d'entrée (V)
# Tension délivrée : e = Ecos(wt)
w = 0.0001
#
wd = math.sqrt(((4*L)/C)-(R*R/(2*L)))
B = (R*E*C*C*w*w*(1-L*C*w*w))/((1-L*C*w*w)*((-L*w*w+L*L*C*w*w*w*w+R*R*w*w*C)*C+1-L*C*w*w))
A = ((-E*w+R*B*w)*C)/(1-L*C*w*w)
A1 = -B;
B1 = ((-R*B)/(2*L*wd))-((A*w)/wd)

# Intervalle de temps
t0 = 0
tf = 10  # Temps final
dt = 0.001  # Pas de temps
t = np.arange(t0, tf + dt, dt)

# Solution particulière :
ip = A*np.sin(w*t) + B*np.cos(w*t)
# Solution homogène :
ih = np.exp(-R*t/(2*L))*(A1*np.cos(wd*t)+B1*np.sin(wd*t))
# Solution générale : 
i = ip + ih;
# Tracé de la solution :
plt.plot(t,i);
plt.xlabel('Temps t(en s)')
plt.ylabel('Intensité i (en A)')
plt.title('Tracé de la solution analytique (système sous-amorti)')
