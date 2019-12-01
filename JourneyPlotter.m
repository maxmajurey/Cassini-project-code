% Run this script following making a array of data taken from
% PlotSaturnData and GetCoordinates

function JourneyPlotter(FILE_NAME)
%creating count variable to work through all of the points of crossing 

i = 1;

SWPArray = {};

eval(['load ',FILE_NAME]);

%plots graph of SC journey

nDataPts = MAGN_SCDA_sSciData.iNumDataPts;
xksm_rs = (MAGN_SCDA_sSciData.XPosn(1:nDataPts))/60280.0D0;
yksm_rs = (MAGN_SCDA_sSciData.YPosn(1:nDataPts))/60280.0D0;
zksm_rs = (MAGN_SCDA_sSciData.ZPosn(1:nDataPts))/60280.0D0;
figure, plot(xksm_rs,sqrt(yksm_rs.^2+zksm_rs.^2));
xlabel('X_{KSM}')
ylabel('(Y_{KSM}^2+Z_{KSM}^2)^{1/2}')
ylim([-10 150])

%save graph

hold on

%reads the crossing coordinate file and outputs it to C in a cell array 

C = FileRead('SOI0.dat');

%superimpose points of crossings onto graph as red +

while i <= length(C{1})
    plot(C{1}(i),(C{2}(i).^2 + C{3}(i).^2).^0.5,'r+:');
    i = i + 1;
    hold on;
end

i=1

while i <= length(C{1})
    cross = (C{1}(i).^2 +(C{2}(i).^2 + C{3}(i).^2))^0.5; %distance from focus point to the crossing used to model bow shock
    phi =(atand(C{1}(i) /(C{2}(i).^2 + C{3}(i).^2).^0.5)); %polar co-ordinate angle with respect to x axis add 90 degrees if x value is negative
    L = cross * (1 + 1.02 * cosd(-phi)); %phi must be manually edited to positive if Y and value is positive
    r = L / (1 + 1.02 * cos(0));
    SWP = (r/12.3)^(-4.3);
    disp(SWP);
    i = i+1;
end

return

end

