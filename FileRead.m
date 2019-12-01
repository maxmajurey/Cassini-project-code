% This script runs as a result of running myPlotter script

function C = myFileRead(fileName)

% Function myFileRead
% Summary: Illustrates file I-O in Matlab
%
% Arguments: 
%    fileName - character string containing name of file

fid = fopen(fileName);
C = textscan(fid, '%f %f %f %f', 'CommentStyle', '%');     
fclose(fid);
            
return

end