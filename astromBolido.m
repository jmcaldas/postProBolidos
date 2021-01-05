function [z,Az] = astromBolido(centroide)

p=load('constantesPlaca.txt');
[z,Az] = ij2horCaldasTancredi(centroide(:,1),centroide(:,2),p);

end
