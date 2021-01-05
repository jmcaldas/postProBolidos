function mV = getmV(matriz,p)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% matriz = [mV Flujo r x]

x = matriz(:,4);
r = matriz(:,3);

% rP=r./240;
% vign = p(1)*rP.^3+p(2)*rP.^2+p(3)*rP+1;
vign=cos(r*p(1)*(pi/180)).^4;
F = matriz(:,2)./vign;

mV = -2.5*log10(F)+p(2)*x+p(3);

end

