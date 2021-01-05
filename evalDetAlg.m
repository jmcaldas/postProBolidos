function [framesArray,nDif,rm,indiceC] = evalDetAlg(vidObj,Mask,delay,thr,nThr,thrR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

duracion=vidObj.Duration;
framerate=vidObj.FrameRate;
nFrames=floor(duracion*framerate);
framesArray=zeros(1,nFrames-1-round(delay*framerate));
rm=zeros(1,nFrames-1-round(delay*framerate));
nDif=zeros(1,nFrames-1-round(delay*framerate));
indiceC=zeros(nFrames-1-round(delay*framerate),2);

for i=1:nFrames-1-delay*framerate
    
    vidObj.CurrentTime=i/framerate;
    anterior=readFrame(vidObj);
    vidObj.CurrentTime=(i+delay*framerate)/framerate;
    este=readFrame(vidObj);
    
    anterior=anterior(:,:,1).*uint8(Mask);
    este=este(:,:,1).*uint8(Mask);
    
    dif=imabsdiff(anterior,este);
    
    nDif(i)=length(find(dif>=thr));
    [I,J]=find(dif>=thr);
    iC=mean(I);
    jC=mean(J);
    rm(i)=median(sqrt((I-iC).^2+(J-jC).^2));
    
    if nDif(i)>=nThr && rm(i)<=thrR
        framesArray(i)=1;
        indiceC(i,:)=[iC jC];
    end
    
end

