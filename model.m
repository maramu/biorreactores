%-------------ODE----------------------------------------
constantes
tspan=[ts tf];
options=odeset('RelTol',1e-6,'AbsTol',1e-6);
y0=[X0 S0 P0 V0];
[tm,ym]=ode45(@fun,tspan,y0,options);
t_n=linspace(ts,tf,n);             % n puntos de tiempo para mostrar
y_n=interp1(tm,ym,t_n,'spline');   % n valores de concentración para mostrar
Xsim=y_n(:,1);Ssim=y_n(:,2);Psim=y_n(:,3); Vsim=y_n(:,4);
Valores_finales=y_n(end,:);


%Ecuaciones/calculos
XV=Xsim.*Vsim;
PV=Psim.*Vsim;
XVfinal=XV(end,:)
musim=mumax.*Ssim./(Ssim+ks);
musimfinal=musim(end,:)

%Representación gráfica
figure(1)
plot(t_n,y_n,'linewidth',3);
title('Reactor fed-batch','FontSize',16,'FontWeight','bold')
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('X, S, P kg/m3 y V m3','FontSize',16,'FontWeight','bold')
legend('X','S', 'P','V')
grid on
hold on

figure(2)
subplot(2,2,1)
plot(t_n,Xsim,'linewidth',3);
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('X,kg/m3','FontSize',16,'FontWeight','bold')
legend('X')
grid on
hold on
subplot(2,2,2)
plot(t_n,Ssim,'g','linewidth',3);
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('S, kg/m3','FontSize',16,'FontWeight','bold')
legend('S')
grid on
hold on
subplot(2,2,3)
plot(t_n,Psim,'r','linewidth',3);
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('P kg/m3','FontSize',16,'FontWeight','bold')
legend('P')
grid on
hold on
subplot(2,2,4)
plot(t_n,Vsim,'m','linewidth',3);
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('V m3','FontSize',16,'FontWeight','bold')
legend('V')
grid on
hold on

figure(3)
plot(t_n,XV,'linewidth',3);
title('Reactor fed-batch','FontSize',16,'FontWeight','bold')
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('XV, kg','FontSize',16,'FontWeight','bold')
legend('XV')
grid on
hold on

figure(4)
plot(t_n,musim,'linewidth',3);
title('Reactor fed-batch','FontSize',16,'FontWeight','bold')
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('mu, h-1','FontSize',16,'FontWeight','bold')
legend('mu')
grid on
hold on

figure(5)
plot(t_n,PV,'linewidth',3);
title('Reactor fed-batch','FontSize',16,'FontWeight','bold')
xlabel('tiempo, horas','FontSize',16,'FontWeight','bold')
ylabel('PV, kg','FontSize',16,'FontWeight','bold')
legend('PV')
grid on
hold on

% Datos
resultados=[t_n',Xsim,Ssim,Psim,Vsim];