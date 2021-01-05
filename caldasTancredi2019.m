 function y = caldasTancredi2019(x,XYZA)

% x1 x0
% x2 y0 
% x3 y0 
% x4...x7: r^0,...,r^3
% x8,x9  : Az=x8+x9*h

% TODO EN RADIANES!

r = sqrt((XYZA(:,1)-x(1)*480).^2+(XYZA(:,2)-x(2)*640).^2);
z = x(3)+(x(4)*r)+(x(5)*r.^2)+(x(6)*r.^3);

h=atan2(XYZA(:,2)-x(2)*640,XYZA(:,1)-x(1)*480);
h=wrapTo2Pi(h);

Az=wrapTo2Pi(x(7)+x(8)*h);

y1 = abs(angdiff(z,XYZA(:,3)));
y2 = abs(angdiff(Az,XYZA(:,4))).*sin(XYZA(:,3));

y=[y1;y2];