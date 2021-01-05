function [z,Az,mV] = astromYfotomBolido(centro,m,n,P,F,id)

p=load(strcat('Station',num2str(id),'/constantesPlaca.txt'));

[z,Az] = ij2horCaldasTancredi(centro(1,1),centro(1,2),p);

x = airMass(rad2deg(z),1); %Kasten & Young
r = sqrt((centro(1,1)-m/2)^2+(centro(1,2)-n/2)^2);
% rP=r./240;
% 
% vign = P(1)*rP.^3+P(2)*rP.^2+P(3)*rP+1;
vign = cos(P(1)*r*(pi/180)).^4;
Fv = F./vign;
mV = -2.5*log10(Fv)+P(2)*x+P(3);

