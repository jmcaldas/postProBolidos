function [star,name,RA,DEC,mV] = readStars(file)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

fid=fopen(file);
M = textscan(fid,'%s%s%s%s%s%s%s%s%s%s%s%s%s%s','Delimiter','\t');
fclose(fid);
n=300;

star=M{2};
name=M{3};
RA=zeros(n,1);
DEC=zeros(n,1);
mV=zeros(n,1);

for i=1:n
    a=str2double(cell(M{4}(i,:)));
    b=str2double(cell(M{5}(i,:)));
    RA(i)=15*(a+b/60);
    DEC(i)=str2double(cell(M{6}(i,:)));
    mV(i)=str2double(cell(M{10}(i,:)));
end

