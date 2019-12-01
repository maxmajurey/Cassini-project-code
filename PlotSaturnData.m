%
% PlotSaturnData
%
% This is a preliminary Matlab script for loading and plotting magnetic
% field components from .mat files containing Cassini magnetometer (MAG)
% observations
%
%

% Edit these parameters for using different files, time limits for plot,
% etc.
%
% START PARAMETERS

FILE_NAME = 'REV_000_A_B.mat';

START_TIME = [2004, 6, 27, 13, 0, 0]  % Format for time is [year, month, date, hr, min, sec
 STOP_TIME = [2004, 7,  7,  22, 0, 0]  % Format for time is [year, month, date, hr, min, sec
 
SATURN_RADIUS_KM = 60280.0D0;

FONT_SIZE = 14; % Font size for plot axes
 
% END PARAMETERS
 
% Load the data

eval(['load ',FILE_NAME]);

% After loading above, the data are stored in a structure called
% MAGN_SCDA_sSciData. Display its contents here:
fnames = fieldnames(MAGN_SCDA_sSciData);

disp('Data structure MAGN_SCDA_sSciData contains fields / sizes:');

for j = 1:length(fnames)
   eval(['sizedummy = size(MAGN_SCDA_sSciData.',fnames{j},');']);
   disp([fnames{j},' (',num2str(sizedummy(1)),',',num2str(sizedummy(2)),')']);
end

% Transform start and end times into Matlab native format
START_TIME_MAT = datenum(START_TIME)
 STOP_TIME_MAT = datenum(STOP_TIME)
 
% Work out the time in hours since the specified start time

% Get the number of actual observational data points in the whole file:
numDataPts = MAGN_SCDA_sSciData.iNumDataPts

timeArr = (MAGN_SCDA_sSciData.fTime(1:numDataPts) - START_TIME_MAT)*24.0D0; % Factor of 24 converts from days to hours

% Now make an example plot.

% This part of the code can be modified. Here we plot field strength
% and spacecraft radial distance from Saturn, both as a function of time
% since specified start time

% Extract field strength in nanoTesla units from the data:
bArr = MAGN_SCDA_sSciData.fBFieldTot(1:numDataPts);

% Now spacecraft radial distance, normalized to the radius of Saturn
rArr = sqrt(MAGN_SCDA_sSciData.XPosn(1:numDataPts).^2 + MAGN_SCDA_sSciData.YPosn(1:numDataPts).^2 + ...
            MAGN_SCDA_sSciData.ZPosn(1:numDataPts).^2) / SATURN_RADIUS_KM;
        
% Try two plots on the same Figure window in Matlab / Octave

subplot(2,1,1);

plot(timeArr, bArr, 'LineWidth', 2);

% Set the time limits of the plot from zero hours to the stop time:
xlim([0 (STOP_TIME_MAT-START_TIME_MAT)*24.0D0]);

ylabel('Field Strength B (nT)')
xlabel(['Hours since ',datestr(START_TIME)]);

% Magnify the scale so that the low field values are visible
ylim([0., 9.99]);

% Expand axis font
set(gca,'FontSize',FONT_SIZE)

subplot(2,1,2);

plot(timeArr, rArr, 'r--', 'LineWidth', 2);

% Set the time limits of the plot from zero hours to the stop time:
xlim([0 (STOP_TIME_MAT-START_TIME_MAT)*24.0D0]);

ylabel('Cassini Rad. Dist (R_S)')
xlabel(['Hours since ',datestr(START_TIME)]);

% Expand axis font
set(gca,'FontSize',FONT_SIZE)


% ADDITIONAL NOTES:
% Placing your cursor over a plotted curve in the Figure window will show you the coordinates of the point 
% at the cursor's current location.
% As a 'first pass' in identifying crossing distances, the cursor can be used to identify a crossing time
% 'by eye' and then a function like interp1 can be used to evaluate spacecraft position at this time, using
% the arrays stored in the data


return

