function dydt=fun(t,y)
constantes;
%Formulación de variables
X=y(1); S=y(2);  P=y(3); V=y(4);
%Ecuaciones del sistema
mu=mumax*S/(ks+S);
qs=mu/Y0xs+ms;
qp=alfa*mu+beta1;
%Sistema de Ecuaciones diferenciales
dXdt=(mu-Q/V)*X;
dSdt=Q/V*(Se-S)-qs*X;
dPdt=qp*X-Q/V*P;
dVdt=Q;
dydt=[dXdt; dSdt; dPdt; dVdt];
end