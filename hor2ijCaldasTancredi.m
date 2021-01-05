function [i,j] = hor2ijCaldasTancredi(z,Az,p)

g=roots([p(6) p(5) p(4) p(3)-z]);
indices= g == real(g);
g=g(indices);
g=g(g>0);
r=min(g);

if isempty(r)
    r=(z-p(3))/p(4);
end
    
h=wrapTo2Pi(angdiff(p(7),Az))/p(8);
h=wrapTo2Pi(h);

i=round(r.*cos(h)+p(1)*480);
j=round(r.*sin(h)+p(2)*640);