function [p,zOut,Azout,XYZA3,res] = astrometria(p0,XYZA)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%p0= 0.5 0.5 0 0 0 0 0 1
P=p0;
errZ0 = 100;
errAZ0 = 100;
nS = 24;
XYZA2=XYZA;

while ((mean(errZ0)>10 || mean(errAZ0)>10))   
    
    f = @(x)caldasTancredi2019(x,XYZA2);
    
    P = lsqnonlin(f,p0);    
    [zOut,Azout] = ij2horCaldasTancredi(XYZA2(:,1),XYZA2(:,2),P);
    errZ0 = 60*(180/pi)*abs(angdiff(zOut,XYZA2(:,3)));
    errAZ0 = 60*(180/pi)*abs(angdiff(Azout,XYZA2(:,4))).*sin(XYZA2(:,3));
    XYZA3=XYZA2;
    
    errores=sqrt(errZ0.^2+errAZ0.^2);
    
    [~,indices]=sortrows(errores);
    
    XYZA2=XYZA2(indices(1:end-1),:);
    nS=size(XYZA2,1);
    
    if nS<12
        break
    end
    
end

p=P;
res(1) = mean([errZ0;errAZ0]); %RMS in arcmin
res(2) = mean(errZ0); %RMS in arcmin
res(3) = mean(errAZ0); %RMS in arcmin