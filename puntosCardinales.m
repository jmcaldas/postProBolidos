function pC = puntosCardinales(mapaZ,mapaAZ)
[m,n]=size(mapaZ);
l = length(mapaZ(:));

a=abs(angdiff(mapaZ(:)*(pi/180),zeros(l,1)+pi/2));
b=abs(angdiff(mapaAZ(:)*(pi/180),zeros(l,1)));
c=sqrt(a.^2+b.^2);
[~,indice]=min(c);
[iN,jN]=ind2sub([m,n],indice);

a=abs(angdiff(mapaZ(:)*(pi/180),zeros(l,1)+pi/2));
b=abs(angdiff(mapaAZ(:)*(pi/180),zeros(l,1)+pi/2));
c=sqrt(a.^2+b.^2);
[~,indice]=min(c);
[iE,jE]=ind2sub([m,n],indice);

a=abs(angdiff(mapaZ(:)*(pi/180),zeros(l,1)+pi/2));
b=abs(angdiff(mapaAZ(:)*(pi/180),zeros(l,1)+pi));
c=sqrt(a.^2+b.^2);
[~,indice]=min(c);
[iS,jS]=ind2sub([m,n],indice);

a=abs(angdiff(mapaZ(:)*(pi/180),zeros(l,1)+pi/2));
b=abs(angdiff(mapaAZ(:)*(pi/180),zeros(l,1)+3*pi/2));
c=sqrt(a.^2+b.^2);
[~,indice]=min(c);
[iO,jO]=ind2sub([m,n],indice);

pC=[iN jN;iE jE;iS jS;iO jO];