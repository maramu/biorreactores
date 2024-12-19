import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt

# -------- CONSTANTS ----------------------------
mumax = 0.25  # Maximum specific growth rate (h^-1)
ks = 0.1      # Saturation constant (kg/m3)
Y0xs = 0.5    # Biomass yield factor (kg biomass/kg substrate)
ms = 0        # Maintenance coefficient (kg substrate/kg biomass/h)
alfa = 0.06   # Product formation coefficient associated with growth (kg product/kg biomass)
beta1 = 0     # Product formation coefficient not associated with growth (kg product/kg biomass/h)

# Initial and final times (h)
ts = 0
tf = 9.3778011

# Initial conditions
X0 = 0.5      # Initial biomass concentration (kg/m3)
S0 = 10       # Initial substrate concentration (kg/m3)
P0 = 0        # Initial product concentration (kg/m3)

# Number of data points to display
n = 20

# -------- ODE SYSTEM ----------------------------
def fun(t, y):
    X, S, P = y
    mu = mumax * S / (ks + S)
    qs = mu / Y0xs + ms
    qp = alfa * mu + beta1
    dXdt = mu * X
    dSdt = -qs * X
    dPdt = qp * X
    return [dXdt, dSdt, dPdt]

# Solve the system
tspan = [ts, tf]
y0 = [X0, S0, P0]
sol = solve_ivp(fun, tspan, y0, method='RK45', t_eval=np.linspace(ts, tf, n), rtol=1e-6, atol=1e-6)

t_n = sol.t
Xsim = sol.y[0]
Ssim = sol.y[1]
Psim = sol.y[2]
musim = mumax * Ssim / (ks + Ssim)

# Final values
Valores_finales = [Xsim[-1], Ssim[-1], Psim[-1]]

# -------- PLOTTING -------------------------------
plt.figure(1)
plt.plot(t_n, Xsim, label='X', linewidth=3)
plt.plot(t_n, Ssim, label='S', linewidth=3)
plt.plot(t_n, Psim, label='P', linewidth=3)
plt.title('Batch Reactor', fontsize=16, fontweight='bold')
plt.xlabel('Time (hours)', fontsize=16, fontweight='bold')
plt.ylabel('Concentrations (kg/m3)', fontsize=16, fontweight='bold')
plt.legend()
plt.grid()

plt.figure(2)
plt.plot(t_n, musim, label='mu', linewidth=3)
plt.title('Batch Reactor', fontsize=16, fontweight='bold')
plt.xlabel('Time (hours)', fontsize=16, fontweight='bold')
plt.ylabel('mu (1/h)', fontsize=16, fontweight='bold')
plt.legend()
plt.grid()

plt.figure(3)
plt.subplot(2, 2, 1)
plt.plot(t_n, Xsim, 'dr', linewidth=1)
plt.xlabel('Time (hours)', fontsize=12, fontweight='bold')
plt.ylabel('X (kg/m3)', fontsize=12, fontweight='bold')
plt.legend(['X'])
plt.grid()

plt.subplot(2, 2, 2)
plt.plot(t_n, Ssim, '^g', linewidth=1)
plt.xlabel('Time (hours)', fontsize=12, fontweight='bold')
plt.ylabel('S (kg/m3)', fontsize=12, fontweight='bold')
plt.legend(['S'])
plt.grid()

plt.subplot(2, 2, 3)
plt.plot(t_n, Psim, '+b', linewidth=1)
plt.xlabel('Time (hours)', fontsize=12, fontweight='bold')
plt.ylabel('P (kg/m3)', fontsize=12, fontweight='bold')
plt.legend(['P'])
plt.grid()

plt.subplot(2, 2, 4)
plt.plot(t_n, musim, '*m', linewidth=1)
plt.xlabel('Time (hours)', fontsize=12, fontweight='bold')
plt.ylabel('mu (1/h)', fontsize=12, fontweight='bold')
plt.legend(['mu'])
plt.grid()

plt.tight_layout()
plt.show()

# Save results
resultados = np.column_stack((t_n, Xsim, Ssim, Psim))
np.savetxt('variables.txt', resultados, header='t X S P', comments='')
