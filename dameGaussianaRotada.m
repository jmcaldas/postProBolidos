function Z = dameGaussianaRotada(x,ii,jj)

theta=x(1);
muX=x(2);
muY=x(3);
sigma_X=x(4);
sigma_Y=x(5);

X=ii;
Y=jj;

a = cos(theta)^2/(2*sigma_X^2) + sin(theta)^2/(2*sigma_Y^2);
b = -sin(2*theta)/(4*sigma_X^2) + sin(2*theta)/(4*sigma_Y^2);
c = sin(theta)^2/(2*sigma_X^2) + cos(theta)^2/(2*sigma_Y^2);

exponente=a*(X-muX).^2+2*b*(X-muX).*(Y-muY)+c*(Y-muY).^2;
Z = exp(-exponente);

end

