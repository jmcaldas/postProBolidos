function [P,matrizFotom2]=fotometria(matrizFotom,promediada,rBack,rStar)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% matrizFotom = [I J mV x]

I=matrizFotom(:,1);
J=matrizFotom(:,2);
count=1;
m=size(promediada,1);n=size(promediada,2);

for index=1:length(I)    
            
        %Compute mean  background sky
        iLO=max(I(index)-rBack,1);
        iHI=min(I(index)+rBack,size(promediada,1));
        jLO=max(J(index)-rBack,1);
        jHI=min(J(index)+rBack,size(promediada,2));
        backgroundSky=promediada(iLO:iHI,jLO:jHI);

        iLO=max(I(index)-rStar,1);
        iHI=min(I(index)+rStar,size(backgroundSky,1));
        jLO=max(J(index)-rStar,1);
        jHI=min(J(index)+rStar,size(backgroundSky,2));
        backgroundSky(iLO:iHI,jLO:jHI)=0;
        backgroundSky=backgroundSky(backgroundSky>=0);
        backgroundSky=mean(double(backgroundSky));

        %Compiute dist. from center for vignetting
        rV=sqrt((I(index)-m/2)^2+(J(index)-n/2)^2);

        %Compute integrated flux
        iLO=max(I(index)-rStar,1);
        iHI=min(I(index)+rStar,size(promediada,1));
        jLO=max(J(index)-rStar,1);
        jHI=min(J(index)+rStar,size(promediada,2));
        flujo=promediada(iLO:iHI,jLO:jHI);
        flujo=double(flujo)-backgroundSky;    

        if sum(sum(flujo))>0
            r(count)=rV; 
            Flujo(count)=(sum(sum(flujo)));  
            x(count)=airMass(matrizFotom(index,4),1); % Kasten & Young
            mV(count)=matrizFotom(index,3);
            count=count+1;
        end
    
end

matrizFotom2=[mV' Flujo' r' x'];

% pL = [-10 -10 -100 -10 -15];
% p0 = [0 4 1 -0.1 7];
% pH = [10 10 100 0 15];

pL = [0.001 -10 -15];
p0 = [0.2 -0.1 7];
pH = [0.9 0 15];

lsqOpts = optimoptions('lsqnonlin', 'MaxFunctionEvaluations', 5000);
f = @(x)caldasTancrediFoto2020(x,matrizFotom2);    
P = lsqnonlin(f,p0,pL,pH,lsqOpts);

mVcalc = getmV(matrizFotom2,P);    
errmV = abs(matrizFotom2(:,1)-mVcalc);

while (mean(errmV)>0.3)   
    
    matrizFotom2=matrizFotom2(abs(errmV-mean(errmV))<std(errmV),:);
    f = @(x)caldasTancrediFoto2020(x,matrizFotom2);    
    P = lsqnonlin(f,p0,pL,pH,lsqOpts);    
    mVcalc = getmV(matrizFotom2,P);    
    errmV = abs(matrizFotom2(:,1)-mVcalc);    
    nS=size(matrizFotom2,1);    
    
    if nS<=12
        break
    end
    
end