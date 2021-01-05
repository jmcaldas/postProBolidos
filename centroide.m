function [iC,jC] = centroide(cuadrado)

f=max(max(cuadrado));
[iC,jC]=find(cuadrado==f);
iC=iC(1);
jC=jC(1);
