function x = airMass(z,model)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if model==0
    x=1./cosd(z);
else
    % Kasten & Young
    x=1./(cosd(z)+(0.50572)*((6.07995+90-z).^(-1.6364)));
end

end

