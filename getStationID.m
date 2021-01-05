function stationID = getStationID(file)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% file is a string of the form: Station_ID_yyyy-mm-dd-hh-mm-ss.avi
% ID has an unknown number of digits
i0=9;
iF=10;
while ~isnan(str2double(file(i0:iF)))
    iF=iF+1;
end
stationID=str2double(file(i0:iF-1));
if stationID==0
    stationID=1;
end


