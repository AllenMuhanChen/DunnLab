clear all
close('all')
%% PSD95 Puncta Analysis
LoadPathLengthStats
listctrT = {'Y5e3Lc1','Y5e3Rc1','U4a5Rc1','U4a5Lc4','U4a5Lc3','U4a5Lc1','V4a1Lc1','V4a1Lc3','V3c2Rc1'};
listctrN = {'Y5e6Lc1','Y5e6Lc2','U4a5Lc2','V4a1Lc2','V4a1Rc2','V4a1Rc3','V3c2Lc1'};
listDT = {'H6a3Rc1','U4b3Lc3','U4b3Lc7','U4b3Rc3','U4b3Rc4','U4b3Rc5','U4b1Rc2'};
listDN = {'H6a1Lc1','U4b3Lc1','U4b3Rc6','U4b3Rc8','B4e1Lc1','B4e1Lc2'};

plotmode = 2; %plotmode 1: original plotting , with all groups on one plot
              %plotmode 2: poster & talk plotting, with plots separated by location
plotDotDensityPSD95Allen   
pointByPointStats
avgStats
totalPunctaStats
punctaDendriteMaximum
punctaCriticalValue
%clearvars -except PUNCTA
%% Sholl Analysis
LoadSkeletonSholl
ShollPlot
shollPointByPointStats
avgShollStats
integralShollStats
shollDendriteMaximum
shollCriticalValue
%% Clearing all vars except PUNCTA & SHOLL
clearvars -except PUNCTA SHOLL