% Run this script following PlotSaturnData, once you have rescaled the plot
% to make clear the individual shock ramp you are studying.

% Drag a rectangle over the plot with the cursor

disp(['Please drag a rectangle over the plot, using the cursor, whose horizontal width covers the shock ramp...']);

rampInfo = getrect;

% Get the start and end times from the rampInfo structure
startRampTime = rampInfo(1);
  endRampTime = rampInfo(1) + rampInfo(3);
  
% Take the average as the nominal crossing position for now:
xingTime = 0.5*(startRampTime + endRampTime)

% Use simple linear interpolation to get the crossing position in km:
noPts = MAGN_SCDA_sSciData.iNumDataPts;
xingXRS = interp1(timeArr, MAGN_SCDA_sSciData.XPosn(1:noPts), xingTime)/60280
xingYRS = interp1(timeArr, MAGN_SCDA_sSciData.YPosn(1:noPts), xingTime)/60280
xingZRS = interp1(timeArr, MAGN_SCDA_sSciData.ZPosn(1:noPts), xingTime)/60280

% Note that 1 RS = 60280 km

return
