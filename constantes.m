%--------CONSTANTES----------------------------
mumax=0.25; % Velocidad especifica máxima de crecimiento (h-1)
ks=0.1;     % Constante de saturación (kg/m3)
Y0xs=0.5;   % Factor de rendimiento biomasa sustrato (kg biomasa/kg sustrato)
ms=0;       % Coeficiente de mantenimiento de células (kg Sustrato/kg biomasa/h)
alfa=0.06;  % Coeficiente de formación de producto asociado al crecimiento (kg producto/kg biomasa)
beta1=0;    % Coeficiente de formación de producto no asociado al crecimiento (kg producto/kg biomasa/h)

Se=100;     % Concentración de sustrato en la alimentación (kg/m3)
Q=0.5;        % Caudal de alimentación (m3/h)

ts=0;       % Tiempo inicial (h) 
tf=28.9196; % Tiempo final (h) 9.3778011
X0=5;     % Concentración de biomasa inicial(kg/m3)
S0=0;      % Concentración de sustrato inicial (kg/m3)
P0=0;       % Concentración de  producto inicial(kg/m3)
V0=2;       % Volumen inicial (m3)
n=200;       % número de datos a mostrar
