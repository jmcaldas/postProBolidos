function [Az El] = RADec2AzEl(RA,Dec,UTC,Lat,Lon,Alt)

% Written by Frank Breitling <fbreitling@aip.de>     2009-10-20
% Based on the program SolarAzEl by Darin C. Koblick 02/17/2009
%
% Function Call Sequence:
% [Az El] = RADec2AzEl(350.858,58.8,'1991/05/19 13:00:00',50,10,0)
%
% Function Description:
% RADecAzEl will ingest a sky position in equatorial coordinates (J2000), 
% a Universal Time, and specific location on earth. It will then
% output the azimuth and elevation angles in the local horizon system.
%
% Input Description:
% RA    Right ascension (J2000) of sky position in degrees (0:360)
% Dec   Declination angle (J2000) of sky position in degrees (-90:90)
% UTC   Coordinated Universal Time YYYY/MM/DD hh:mm:ss
% Lat   Latitude of location in degrees -90:90 -> S(-) N(+)
% Lon   Longitude of location in degrees -180:180 W(-) E(+)
% Alt   Altitude of location above sea level (km)
%
% Output Description:
% Az    Azimuth angle of position in degrees (0:360)
% El    Elevation angle of position in degrees (-90:90)
%
% Source References:
% http://www.mathworks.com/matlabcentral/fileexchange/23051-solar-azimuth-and-elevation-estimation


% Code Sequence:

% Compute JD
jd = juliandate(UTC,'yyyy/mm/dd HH:MM:SS');
d = jd-2451543.5;

% Keplerian Elements for the Sun (geocentric)
w = 282.9404+4.70935e-5*d;            % longitude of perihelion degrees
M = mod(356.0470+0.9856002585*d,360); % mean anomaly degrees
L = w + M;                            % Sun's mean longitude degrees

% Following the RA DEC to Az Alt conversion sequence explained here:
% http://www.stargazing.net/kepler/altaz.html

% Find the J2000 value
J2000 = jd - 2451545.0;
hourvec = datevec(UTC,'yyyy/mm/dd HH:MM:SS');
UTH = hourvec(4) + hourvec(5)/60 + hourvec(6)/3600;

% Calculate local siderial time
GMST0=mod(L+180,360)/15;
SIDTIME = GMST0 + UTH + Lon/15;

% Replace RA with hour angle HA
HA = (SIDTIME*15 - RA);

% Convert to rectangular coordinate system
x = cos(HA.*(pi/180)).*cos(Dec.*(pi/180));
y = sin(HA.*(pi/180)).*cos(Dec.*(pi/180));
z = sin(Dec.*(pi/180));

% Rotate this along an axis going east-west.
xhor = x.*cos((90-Lat).*(pi/180))-z.*sin((90-Lat).*(pi/180));
yhor = y;
zhor = x.*sin((90-Lat).*(pi/180))+z.*cos((90-Lat).*(pi/180));

% Find the h and AZ 
Az = atan2(yhor,xhor).*(180/pi) + 180;
El = asin(zhor).*(180/pi);


function jd = juliandate(varargin)
% This sub function is provided in case juliandate does not come with your 
% distribution of Matlab

[year month day hour min sec] = datevec(datenum(varargin{:}));

for k = length(month):-1:1
    if ( month(k) <= 2 ) % january & february
        year(k)  = year(k) - 1.0;
        month(k) = month(k) + 12.0;
    end
end

jd =floor( 365.25*(year + 4716.0)) + floor( 30.6001*( month + 1.0)) + 2.0 - ...
    floor( year/100.0 ) + floor( floor( year/100.0 )/4.0 ) + day - 1524.5 + ...
    (hour + min/60 + sec/3600)/24;
