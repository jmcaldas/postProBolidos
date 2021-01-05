function F = integrarFlujoBolido(Z)

% k=x(1);
% theta=x(2);
% muX=x(3);
% muY=x(4);
% sigma_X=x(5);
% sigma_Y=x(6);

pico=max(max(Z));

F=sum(sum(Z(Z>=0.05*pico)));

end
