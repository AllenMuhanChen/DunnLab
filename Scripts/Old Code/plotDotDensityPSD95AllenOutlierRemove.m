% Accumulate and plot puncta density, as result of DotFinder analysis.
% -------------------------------------------------------------------------
% Coded by: Luca Della Santina 
% Date: August 7th 2012
% Edited by: Allen Chen
% Date: 7/18/18


tmpVars=who;
tmpMaxDist = 150; %Maximal distance from soma to plot density
% [tmpSel] = listdlg('PromptString','Choose Control', 'ListString', tmpVars);

%ctr - DTR-
%1 - Temporal
%2 - Nasal
% listctrT = {'Y5e3Lc1','Y5e3Rc1','U4a5Rc1','U4a5Lc4','U4a5Lc3','U4a5Lc1','V4a1Lc1','V4a1Lc3','V3c2Rc1'};
% listctrN = {'Y5e6Lc1','Y5e6Lc2','U4a5Lc2','V4a1Lc2','V4a1Rc2','V4a1Rc3','V3c2Lc1'};
% listDT = {'H6a3Rc1','H6a4Rc1','U4b3Lc3','U4b3Lc7','U4b3Rc3','U4b3Rc4','U4b3Rc5','U4b1Rc2'};
% listDN = {'H6a1Lc1','U4b3Lc1','U4b3Rc6','U4b3Rc8','B4e1Lc1','B4e1Lc2'};
listctrT = {'U4a5Rc1','U4a5Lc4','U4a5Lc3','U4a5Lc1','V4a1Lc1','V4a1Lc3','V3c2Rc1'};
listctrN = {'U4a5Lc2','V4a1Lc2','V4a1Rc2','V4a1Rc3','V3c2Lc1'};
listDT = {'U4b3Lc3','U4b3Lc7','U4b3Rc3','U4b3Rc4','U4b3Rc5','U4b1Rc2'};
listDN = {'U4b3Lc1','U4b3Rc6','U4b3Rc8','B4e1Lc1','B4e1Lc2'};

%Control 1
[~, selctrT] = intersect(tmpVars, listctrT);
tmpSel = sort(selctrT);
tmpPDctrT = NaN(numel(tmpSel), tmpMaxDist);
for i=1:numel(tmpSel)
    tmpSkel=evalin('base',char(tmpVars(tmpSel(i))));
    if numel(tmpSkel.PoverDvsPathLength)>=tmpMaxDist
        tmpPDctrT(i, :) = tmpSkel.PoverDvsPathLength(1:tmpMaxDist);
    else
        tmpPDctrT(i, 1:numel(tmpSkel.PoverDvsPathLength)) = tmpSkel.PoverDvsPathLength(:);
    end
end
tmpAvgPDctrT = nanmean(tmpPDctrT,2); %Average Dot Density

%Control 2
[~, selctrN] = intersect(tmpVars, listctrN);
tmpSel = sort(selctrN);
tmpPDctrN = NaN(numel(tmpSel), tmpMaxDist);
for i=1:numel(tmpSel)
    tmpSkel=evalin('base',char(tmpVars(tmpSel(i))));
    if numel(tmpSkel.PoverDvsPathLength)>=tmpMaxDist
        tmpPDctrN(i, :) = tmpSkel.PoverDvsPathLength(1:tmpMaxDist);
    else
        tmpPDctrN(i, 1:numel(tmpSkel.PoverDvsPathLength)) = tmpSkel.PoverDvsPathLength(:);
    end
end
tmpAvgPDctrN = nanmean(tmpPDctrN,2); %Average Dot Density


%Treatment 1
[~, selDT] = intersect(tmpVars, listDT);
tmpSel = sort(selDT);
%[tmpSel] = listdlg('PromptString','Choose Treated 1', 'ListString', tmpVars);
tmpPDDT = NaN(numel(tmpSel), tmpMaxDist);
for i=1:numel(tmpSel)
    tmpSkel=evalin('base',char(tmpVars(tmpSel(i))));
    if numel(tmpSkel.PoverDvsPathLength)>=tmpMaxDist
        tmpPDDT(i, :) = tmpSkel.PoverDvsPathLength(1:tmpMaxDist);
    else
        tmpPDDT(i, 1:numel(tmpSkel.PoverDvsPathLength)) = tmpSkel.PoverDvsPathLength(:);
    end
end
tmpAvgPDDT = nanmean(tmpPDDT,2);

%Treatment 2
%[tmpSel] = listdlg('PromptString','Choose Treated 2', 'ListString', tmpVars);
[~, selDN] = intersect(tmpVars, listDN);
tmpSel = sort(selDN);
tmpPDDN = NaN(numel(tmpSel), tmpMaxDist);
for i=1:numel(tmpSel)
    tmpSkel=evalin('base',char(tmpVars(tmpSel(i))));
    if numel(tmpSkel.PoverDvsPathLength)>=tmpMaxDist
        tmpPDDN(i, :) = tmpSkel.PoverDvsPathLength(1:tmpMaxDist);
    else
        tmpPDDN(i, 1:numel(tmpSkel.PoverDvsPathLength)) = tmpSkel.PoverDvsPathLength(:);
    end
end
tmpAvgPDDN = nanmean(tmpPDDN,2);

%% Outlier REMOVAL
tmpAvgPDDT_OUTLIER = tmpAvgPDDT;
tmpAvgPDDT_OUTLIER(5) = [];

tmpPDDT_OUTLIER = tmpPDDT;
tmpPDDT_OUTLIER(5,:) = [];
%% 
% Average values and statistical comparisons. OUTLIER NOT REMOVED
ctrTSEM = std(tmpAvgPDctrT)/sqrt(numel(tmpAvgPDctrT));
ctrNSEM = std(tmpAvgPDctrN)/sqrt(numel(tmpAvgPDctrN));
DTSEM = std(tmpAvgPDDT)/sqrt(numel(tmpAvgPDDT));
DNSEM = std(tmpAvgPDDN)/sqrt(numel(tmpAvgPDDN));

disp('-------------------------------------');
disp('Average density (dots/micron, SEM). OUTLIER NOT REMOVED ');
disp('-------------------------------------');
disp(['Ctrl T: ' num2str(mean(tmpAvgPDctrT)) setstr(177) num2str(ctrTSEM) ' n=' num2str(numel(tmpAvgPDctrT))]);
disp(['Ctrl N: ' num2str(mean(tmpAvgPDctrN)) setstr(177) num2str(ctrNSEM) ' n=' num2str(numel(tmpAvgPDctrN))]);
disp(['DTR T: ' num2str(mean(tmpAvgPDDT)) setstr(177) num2str(DTSEM) ' n=' num2str(numel(tmpAvgPDDT))]);
disp(['DTR N: ' num2str(mean(tmpAvgPDDN)) setstr(177) num2str(DNSEM) ' n=' num2str(numel(tmpAvgPDDN))]);
disp(' ');
disp('-------------------------------------');
disp('Statistical comparison (ranksum test). OUTLIER NOT REMOVED');
disp('-------------------------------------');
tmpPc1_t1 = ranksum(tmpAvgPDDT, tmpAvgPDctrT);
disp(sprintf('Avg density DTR T vs Ctr T.... p = %3.5f', tmpPc1_t1));
tmpPc2_t2 = ranksum(tmpAvgPDDN, tmpAvgPDctrN);
disp(sprintf('Avg density DTR N vs Ctr N.... p = %3.5f', tmpPc2_t2));
tmpPc1_c2 = ranksum(tmpAvgPDctrT, tmpAvgPDctrN);
disp(sprintf('Avg density Ctr T vs Ctr N.... p = %3.5f', tmpPc1_c2));
tmpPt1_t2 = ranksum(tmpAvgPDDT, tmpAvgPDDN);
disp(sprintf('Avg density DTR T vs DTR N.... p = %3.5f', tmpPt1_t2));



%% 
% Average values and statistical comparisons. OUTLIER REMOVED
ctrTSEM = std(tmpAvgPDctrT)/sqrt(numel(tmpAvgPDctrT));
ctrNSEM = std(tmpAvgPDctrN)/sqrt(numel(tmpAvgPDctrN));
DTSEM_OUTLIER = std(tmpAvgPDDT_OUTLIER)/sqrt(numel(tmpAvgPDDT_OUTLIER));
DNSEM = std(tmpAvgPDDN)/sqrt(numel(tmpAvgPDDN));

disp('-------------------------------------');
disp('Average density (dots/micron, SEM). OUTLIER REMOVED ');
disp('-------------------------------------');
disp(['Ctrl T: ' num2str(mean(tmpAvgPDctrT)) setstr(177) num2str(ctrTSEM) ' n=' num2str(numel(tmpAvgPDctrT))]);
disp(['Ctrl N: ' num2str(mean(tmpAvgPDctrN)) setstr(177) num2str(ctrNSEM) ' n=' num2str(numel(tmpAvgPDctrN))]);
disp(['DTR T: ' num2str(mean(tmpAvgPDDT_OUTLIER)) setstr(177) num2str(DTSEM_OUTLIER) ' n=' num2str(numel(tmpAvgPDDT_OUTLIER))]);
disp(['DTR N: ' num2str(mean(tmpAvgPDDN)) setstr(177) num2str(DNSEM) ' n=' num2str(numel(tmpAvgPDDN))]);
disp(' ');
disp('-------------------------------------');
disp('Statistical comparison (ranksum test). OUTLIER REMOVED');
disp('-------------------------------------');
tmpPc1_t1_OUTLIER = ranksum(tmpAvgPDDT_OUTLIER, tmpAvgPDctrT);
disp(sprintf('Avg density DTR T vs Ctr T.... p = %3.5f', tmpPc1_t1_OUTLIER));
tmpPc2_t2 = ranksum(tmpAvgPDDN, tmpAvgPDctrN);
disp(sprintf('Avg density DTR N vs Ctr N.... p = %3.5f', tmpPc2_t2));
tmpPc1_c2 = ranksum(tmpAvgPDctrT, tmpAvgPDctrN);
disp(sprintf('Avg density Ctr T vs Ctr N.... p = %3.5f', tmpPc1_c2));
tmpPt1_t2_OUTLIER = ranksum(tmpAvgPDDT_OUTLIER, tmpAvgPDDN);
disp(sprintf('Avg density DTR T vs DTR N.... p = %3.5f', tmpPt1_t2_OUTLIER));

%% Plot dot density OUTLIER NOT REMOVED (Updated Luca's plot)

%Defining Colors
primary1 = [166/255,206/255,227/255];
secondary1  = [31/255,120/255,180/255];
primary2 = [178/255,223/255,138/255];
secondary2 = [51/255,160/255,44/255];
primary3 = [251/255,154/255,153/255];
secondary3 = [227/255,26/255,28/255];
primary4 = [253/255,191/255,111/255];
secondary4 = [255/255,127/255,0/255];

tmpH = figure('Name', 'Sholl analysis');
set(tmpH, 'Position', [100 200 1200 500]);

set(gcf, 'DefaultAxesFontName', 'Arial');
set(gcf, 'DefaultTextFontSize', 16);
set(gcf, 'DefaultAxesFontName', 'Arial')
set(gcf, 'DefaultAxesFontSize', 16)
%plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor',color, 'FaceAlpha', 0.25, 'HandleVisibility', 'off');
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor','none', 'FaceAlpha', 0.25, 'HandleVisibility', 'off');
%whitebg(gcf);

%Plot control density 1
subplot('position', [0.06 0.12 0.7 0.8]);
hold on;
tmpY = nanmean(tmpPDctrT);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDctrT)/sqrt(size(tmpPDctrT,1));
%plot(nanmean(tmpPDctrT) + nanstd(tmpPDctrT)/sqrt(size(tmpPDctrT,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(tmpPDctrT) - nanstd(tmpPDctrT)/sqrt(size(tmpPDctrT,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY-margin,tmpY+margin,primary1)
plot(tmpY, 'Color', secondary1, 'MarkerSize', 8);

%Plot control density 2
tmpY = nanmean(tmpPDctrN);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDctrN)/sqrt(size(tmpPDctrN,1));
%plot(nanmean(tmpPDctrN) + nanstd(tmpPDctrN)/sqrt(size(tmpPDctrN,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(tmpPDctrN) - nanstd(tmpPDctrN)/sqrt(size(tmpPDctrN,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY-margin,tmpY+margin,primary2)
plot(tmpY, 'Color', secondary2,'MarkerSize', 8);

%Plot treated 1 density
tmpY = nanmean(tmpPDDT);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDDT)/sqrt(size(tmpPDDT,1));
%plot(nanmean(tmpPDDT) + nanstd(tmpPDDT)/sqrt(size(tmpPDDT,1)), 'r', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(tmpPDDT) - nanstd(tmpPDDT)/sqrt(size(tmpPDDT,1)), 'r', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY-margin,tmpY+margin,primary3)
plot(tmpY, 'Color',secondary3, 'MarkerSize', 8);

%Plot treated 2 density
tmpY = nanmean(tmpPDDN);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDDN)/sqrt(size(tmpPDDN,1));
%plot(nanmean(tmpPDDN) + nanstd(tmpPDDN)/sqrt(size(tmpPDDN,1)), 'g', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(tmpPDDN) - nanstd(tmpPDDN)/sqrt(size(tmpPDDN,1)), 'g', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY-margin,tmpY+margin,primary4)
plot(tmpY, 'Color',secondary4, 'MarkerSize', 8);

%Graphic adjustments
box off;
title('PSD95 density along dendrites');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0 tmpMaxDist]);
ylim([0 1]);
xlabel('Distance from soma (�m)');
ylabel('PSD95 density (puncta/�m)');
legend({'WT Temporal','WT Nasal', 'DTR Temporal', 'DTR Nasal'})
    
%Plot average density
subplot('position', [0.8 0.12 0.18 0.8]);
hold on;
tmpH = bar([1:4], [mean(tmpAvgPDctrT) mean(tmpAvgPDctrN), mean(tmpAvgPDDT), mean(tmpAvgPDDN)], 'k');
set(tmpH,'FaceColor','none')

errorbar(1, mean(tmpAvgPDctrT), std(tmpAvgPDctrT)/sqrt(numel(tmpAvgPDctrT)), 'Color',secondary1);
errorbar(2, mean(tmpAvgPDctrN), std(tmpAvgPDctrN)/sqrt(numel(tmpAvgPDctrN)), 'Color',secondary2);
errorbar(3, mean(tmpAvgPDDT), std(tmpAvgPDDT)/sqrt(numel(tmpAvgPDDT)), 'Color',secondary3);
errorbar(4, mean(tmpAvgPDDN), std(tmpAvgPDDN)/sqrt(numel(tmpAvgPDDN)), 'Color',secondary4);

for i=1:numel(tmpAvgPDctrT);
    plot(1,tmpAvgPDctrT(i),'Marker','o','Color',primary1,'MarkerSize', 8);
end
for i=1:numel(tmpAvgPDctrN);
    plot(2,tmpAvgPDctrN(i),'Marker','o','Color',primary2,'MarkerSize', 8);
end
for i=1:numel(tmpAvgPDDT);
    plot(3,tmpAvgPDDT(i),'Marker','o','Color',primary3,'MarkerSize', 8);
end
 for i=1:numel(tmpAvgPDDN);
     plot(4,tmpAvgPDDN(i),'Marker','o','Color',primary4,'MarkerSize', 8);
 end

box off;
title('Average PSD95 density');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0.5 4.5]);
ylim([0 1]);
set(gca,'XTick',[1 2 3 4]);
set(gca,'xtickLabel',{'WT T', 'WT N', 'DTR T', 'DTR N'});
                  

%% Plot dot density OUTLIER REMOVED (Updated Luca's plot)

%Defining Colors
primary1 = [166/255,206/255,227/255];
secondary1  = [31/255,120/255,180/255];
primary2 = [178/255,223/255,138/255];
secondary2 = [51/255,160/255,44/255];
primary3 = [251/255,154/255,153/255];
secondary3 = [227/255,26/255,28/255];
primary4 = [253/255,191/255,111/255];
secondary4 = [255/255,127/255,0/255];

tmpH = figure('Name', 'Sholl analysis - OUTLIER REMOVED');
set(tmpH, 'Position', [100 200 1200 500]);

set(gcf, 'DefaultAxesFontName', 'Arial');
set(gcf, 'DefaultTextFontSize', 16);
set(gcf, 'DefaultAxesFontName', 'Arial')
set(gcf, 'DefaultAxesFontSize', 16)
%plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor',color, 'FaceAlpha', 0.25, 'HandleVisibility', 'off');
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor','none', 'FaceAlpha', 0.25, 'HandleVisibility', 'off');
%whitebg(gcf);

%Plot control density 1
subplot('position', [0.06 0.12 0.7 0.8]);
hold on;
tmpY = nanmean(tmpPDctrT);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDctrT)/sqrt(size(tmpPDctrT,1));
%plot(nanmean(tmpPDctrT) + nanstd(tmpPDctrT)/sqrt(size(tmpPDctrT,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(tmpPDctrT) - nanstd(tmpPDctrT)/sqrt(size(tmpPDctrT,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY-margin,tmpY+margin,primary1)
plot(tmpY, 'Color', secondary1, 'MarkerSize', 8);

%Plot control density 2
tmpY = nanmean(tmpPDctrN);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDctrN)/sqrt(size(tmpPDctrN,1));
%plot(nanmean(tmpPDctrN) + nanstd(tmpPDctrN)/sqrt(size(tmpPDctrN,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(tmpPDctrN) - nanstd(tmpPDctrN)/sqrt(size(tmpPDctrN,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY-margin,tmpY+margin,primary2)
plot(tmpY, 'Color', secondary2,'MarkerSize', 8);

%Plot treated 1 density - OUTLIER REMOVED
tmpY = nanmean(tmpPDDT_OUTLIER);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDDT_OUTLIER)/sqrt(size(tmpPDDT_OUTLIER,1));
%plot(nanmean(tmpPDDT) + nanstd(tmpPDDT)/sqrt(size(tmpPDDT,1)), 'r', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(tmpPDDT) - nanstd(tmpPDDT)/sqrt(size(tmpPDDT,1)), 'r', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY-margin,tmpY+margin,primary3)
plot(tmpY, 'Color',secondary3, 'MarkerSize', 8);

%Plot treated 2 density
tmpY = nanmean(tmpPDDN);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDDN)/sqrt(size(tmpPDDN,1));
%plot(nanmean(tmpPDDN) + nanstd(tmpPDDN)/sqrt(size(tmpPDDN,1)), 'g', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(tmpPDDN) - nanstd(tmpPDDN)/sqrt(size(tmpPDDN,1)), 'g', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY-margin,tmpY+margin,primary4)
plot(tmpY, 'Color',secondary4, 'MarkerSize', 8);

%Graphic adjustments
box off;
title('PSD95 density along dendrites - OUTLIER REMOVED');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0 tmpMaxDist]);
ylim([0 1]);
xlabel('Distance from soma (�m)');
ylabel('PSD95 density (puncta/�m)');
legend({'WT Temporal','WT Nasal', 'DTR Temporal', 'DTR Nasal'})
    
%Plot average density
subplot('position', [0.8 0.12 0.18 0.8]);
hold on;
tmpH = bar([1:4], [mean(tmpAvgPDctrT) mean(tmpAvgPDctrN), mean(tmpAvgPDDT), mean(tmpAvgPDDN)], 'k');
set(tmpH,'FaceColor','none')

errorbar(1, mean(tmpAvgPDctrT), std(tmpAvgPDctrT)/sqrt(numel(tmpAvgPDctrT)), 'Color',secondary1);
errorbar(2, mean(tmpAvgPDctrN), std(tmpAvgPDctrN)/sqrt(numel(tmpAvgPDctrN)), 'Color',secondary2);
errorbar(3, mean(tmpAvgPDDT_OUTLIER), std(tmpAvgPDDT_OUTLIER)/sqrt(numel(tmpAvgPDDT_OUTLIER)), 'Color',secondary3);
errorbar(4, mean(tmpAvgPDDN), std(tmpAvgPDDN)/sqrt(numel(tmpAvgPDDN)), 'Color',secondary4);

for i=1:numel(tmpAvgPDctrT);
    plot(1,tmpAvgPDctrT(i),'Marker','o','Color',primary1,'MarkerSize', 8);
end
for i=1:numel(tmpAvgPDctrN);
    plot(2,tmpAvgPDctrN(i),'Marker','o','Color',primary2,'MarkerSize', 8);
end
for i=1:numel(tmpAvgPDDT_OUTLIER);
    plot(3,tmpAvgPDDT_OUTLIER(i),'Marker','o','Color',primary3,'MarkerSize', 8);
end
 for i=1:numel(tmpAvgPDDN);
     plot(4,tmpAvgPDDN(i),'Marker','o','Color',primary4,'MarkerSize', 8);
 end

box off;
title('Average PSD95 density-OUTLIER REMOVED');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0.5 4.5]);
ylim([0 1]);
set(gca,'XTick',[1 2 3 4]);
set(gca,'xtickLabel',{'WT T', 'WT N', 'DTR T', 'DTR N'});
                  


%clear tmp* i margin plot_variance;

