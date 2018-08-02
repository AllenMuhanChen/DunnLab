% Finds the integral under the sholl curve for each cell, averages and runs
% stats. Plots as well. 

tempSIctrT = SIctrT;
tempSIctrN = SIctrN;
tempSIDT = SIDT;
tempSIDN = SIDN;

tempSIctrT(isnan(tempSIctrT)) = 0;
tempSIctrN(isnan(tempSIctrN)) = 0;
tempSIDT(isnan(tempSIDT)) = 0;
tempSIDN(isnan(tempSIDN)) = 0;

integralSIctrT = trapz(tempSIctrT');
integralSIctrN = trapz(tempSIctrN');
integralSIDT = trapz(tempSIDT');
integralSIDN = trapz(tempSIDN');

allValues = cat(2,integralSIctrT, integralSIctrN, integralSIDT, integralSIDN);

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(integralSIctrT,2) + size(integralSIctrN,2)) = {'WT'};
aLevels(:,size(integralSIctrT,2) + size(integralSIctrN,2) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'integralSIctrT', 'integralSIctrN', 'integralSIDT', 'integralSIDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,2);',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[SHOLL.integralANOVA.p,~,SHOLL.integralANOVA.stats] = anovan(allValues(:), {aLevels, bLevels(:)}, 'Display', 'off');

disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(SHOLL.integralANOVA.p(1))]);
disp(['factor  Location,             p = ' num2str(SHOLL.integralANOVA.p(2))]);
disp(' ');
% 
% figure; 
% [SHOLL.integralANOVA.ttests.c SHOLL.integralANOVA.ttests.m SHOLL.integralANOVA.ttests.h SHOLL.integralANOVA.ttests.gnames] = multcompare(SHOLL.integralANOVA.stats,'Dimension', [1 2],'CType', 'bonferroni');
% title('TWO-WAY: Treatment & Location. Sholl Intersections Area Under Distance');
% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')

%% Plot Average Areas
if plotmode == 1
set(0, 'currentfigure',shollH)
subplot('position', [0.825 0.56 0.17 0.4]);
hold on;
tmpH = bar([1:4], [nanmean(integralSIctrT) nanmean(integralSIctrN), nanmean(integralSIDT), nanmean(integralSIDN)], 'k');
set(tmpH,'FaceColor','none')

errorbar(1, nanmean(integralSIctrT), nanstd(integralSIctrT)/sqrt(numel(integralSIctrT)), 'Color',secondary1);
errorbar(2, nanmean(integralSIctrN), nanstd(integralSIctrN)/sqrt(numel(integralSIctrN)), 'Color',secondary2);
errorbar(3, nanmean(integralSIDT), nanstd(integralSIDT)/sqrt(numel(integralSIDT)), 'Color',secondary3);
errorbar(4, nanmean(integralSIDN), nanstd(integralSIDN)/sqrt(numel(integralSIDN)), 'Color',secondary4);

for i=1:numel(integralSIctrT)
    plot(1,integralSIctrT(i),'Marker','o','Color',primary1,'MarkerSize', 8);
end
for i=1:numel(integralSIctrN)
    plot(2,integralSIctrN(i),'Marker','o','Color',primary2,'MarkerSize', 8);
end
for i=1:numel(integralSIDT)
    plot(3,integralSIDT(i),'Marker','o','Color',primary3,'MarkerSize', 8);
end
 for i=1:numel(integralSIDN)
     plot(4,integralSIDN(i),'Marker','o','Color',primary4,'MarkerSize', 8);
 end

box off;
title('Total Dendrite Complexity');
set(get(gca, 'title'),'Units','normalized')
set(get(gca, 'title'),'Position',[0.5 1.025 0])
set(gca, 'color', 'none',  'TickDir','out');
xlim([0.5 4.5]);
%ylim([0 1]);
set(gca,'XTick',[1 2 3 4]);
set(gca,'xtickLabel',{'WT T', 'WT N', 'DTR T', 'DTR N'});
end 
