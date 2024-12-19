# biorreactors
function batchmonod

%--------CONSTANTES----------------------------
mumax=0.25; % Velocidad especifica máxima de crecimiento (h-1)
ks=0.1;     % Constante de saturación (kg/m3)
Y0xs=0.5;   % Factor de rendimiento biomasa sustrato (kg biomasa/kg sustrato)
ms=0;       % Coeficiente de mantenimiento de células (kg Sustrato/kg biomasa/h)
alfa=0.06;  % Coeficiente de formación de producto asociado al crecimiento (kg producto/kg biomasa)
beta1=0;    % Coeficiente de formación de producto no asociado al crecimiento (kg producto/kg biomasa/h)

ts=0;       % Tiempo inicial (h) 
tf=9.3778011; % Tiempo final (h) 9.3778011
X0=0.5;     % Concentración de biomasa inicial(kg/m3)
S0=10;      % Concentración de sustrato inicial (kg/m3)
P0=0;       % Concentración de  producto inicial(kg/m3)
n=20;       % número de datos a mostrar

%---------ODE -----------------------------------------------
tspan=[ts tf];
options=odeset('RelTol',1e-6,'AbsTol',1e-6);
y0=[X0 S0 P0];
[tm,ym]=ode45(@fun,tspan,y0,options);
t_n=linspace(ts,tf,n);             % n puntos de tiempo para mostrar
y_n=interp1(tm,ym,t_n,'spline');   % n valores de concentración para mostrar
Xsim=y_n(:,1);Ssim=y_n(:,2);Psim=y_n(:,3);
Valores_finales=y_n(end,:)
musim=mumax*Ssim./(ks+Ssim);

%-------GRAFICOS----------------------------------------
figure(1)
plot(t_n,y_n,'linewidth',3);
title('Reactor discontinuo','FontSize',16,'FontWeight','bold')
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('X, S, P , kg/m3','FontSize',16,'FontWeight','bold')
legend('X','S','P')
hold on

figure(2)
plot(t_n,musim,'linewidth',3);
title('Reactor discontinuo','FontSize',16,'FontWeight','bold')
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('mu, 1/h','FontSize',16,'FontWeight','bold')
legend('mu')
hold on
figure(2)
plot(t_n,musim,'linewidth',3);
title('Reactor discontinuo','FontSize',16,'FontWeight','bold')
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('mu, 1/h','FontSize',16,'FontWeight','bold')
legend('mu')
grid

figure (3)
subplot(2,2,1);
plot(t_n,Xsim,'dr','linewidth',1);
xlabel('tiempo, horas','FontSize',12,'FontWeight','bold')
ylabel('X, kg/m3','FontSize',12,'FontWeight','bold')
legend('X')
grid
subplot(2,2,2);
plot(t_n,Ssim,'^g','linewidth',1);
xlabel('tiempo, horas','FontSize',12,'FontWeight','bold')
ylabel('S, kg/m3','FontSize',12,'FontWeight','bold')
legend('S')
grid
subplot(2,2,3);
plot(t_n,Psim,'+b','linewidth',1);
xlabel('tiempo, horas','FontSize',12,'FontWeight','bold')
ylabel('P, kg/m3','FontSize',12,'FontWeight','bold')
legend('P')
grid
subplot(2,2,4);
plot(t_n,musim,'*m','linewidth',1);
xlabel('tiempo, horas','FontSize',12,'FontWeight','bold')
ylabel('mu, 1/h','FontSize',12,'FontWeight','bold')
legend('mu')
grid

% Datos
resultados=[t_n',Xsim,Ssim,Psim];
% Crear un archivo con todos las variables
save('variables.mat')

%-----FUNCIÓN------------------------------------------
function dydt=fun(t,y)
    %Formulación de variables
    X=y(1); S=y(2);  P=y(3);
    %Ecuaciones del sistema
    mu=mumax*S/(ks+S);
    qs=mu/Y0xs+ms;
    qp=alfa*mu+beta1;
    %Sistema de Ecuaciones diferenciales
    dXdt=mu*X;
    dSdt=-qs*X;
    dPdt=qp*X;
    dydt=[dXdt; dSdt; dPdt];
end
end
