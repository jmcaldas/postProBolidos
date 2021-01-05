function fecha = getDate(file)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% file is a string of the form: Station_ID_yyyy-mm-dd-hh-mm-ss.avi
% ID has an unknown number of digits
i0=11;
iF=29;

stationID=getStationID(file);

if length(stationID)>1
    i0=i0+1;
    iF=iF+1;
end

fecha=file(i0:iF);

end



