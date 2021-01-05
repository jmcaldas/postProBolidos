function y = caldasTancrediFoto2020(x,matrizFotom2)

% matrizFotom2=[mV Flujo' r' x'];

mV = matrizFotom2(:,1);
F = matrizFotom2(:,2);
r = matrizFotom2(:,3);
x1 = matrizFotom2(:,4);

%vignetting correction of F
vign=cos(r*x(1)*(pi/180)).^4;
F = F./vign;

y = abs(mV+2.5*log10(F)-x(2)*x1-x(3));