function [z,Az] = ij2horCaldasTancredi(i,j,p)

r = sqrt((i-p(1)*480).^2+(j-p(2)*640).^2);
z = p(3)+(p(4)*r)+(p(5)*r.^2)+(p(6)*r.^3);

h=atan2(j-p(2)*640,i-p(1)*480);
h=wrapTo2Pi(h);

Az=wrapTo2Pi(p(7)+p(8)*h);
