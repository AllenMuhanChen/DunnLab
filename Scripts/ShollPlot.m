%Plots number of sholl intersections across & averaged across dendrite length 
% 
% listctrT = {'Y5e3Lc1','Y5e3Rc1','U4a5Rc1','U4a5Lc4','U4a5Lc3','U4a5Lc1','V4a1Lc1','V4a1Lc3','V3c2Rc1'};
% listctrN = {'Y5e6Lc1','Y5e6Lc2','U4a5Lc2','V4a1Lc2','V4a1Rc2','V4a1Rc3','V3c2Lc1'};
% listDT = {'H6a3Rc1','U4b3Lc3','U4b3Lc7','U4b3Rc3','U4b3Rc4','U4b3Rc5','U4b1Rc2'};
% listDN = {'H6a1Lc1','U4b3Lc1','U4b3Rc6','U4b3Rc8','B4e1Lc1','B4e1Lc2'};
tmpMaxDist = 150;

avgSIctrT = [];
SIctrT = [];
for i=1:numel(listctrT)
    eval(sprintf('SHOLL.avg.%s.value = mean(SHOLL.raw.%s(:,2));', listctrT{i},listctrT{i}));
    eval(sprintf('SHOLL.avg.%s.type = ''WT Temporal'';', listctrT{i}));
    eval(sprintf('avgSIctrT = [avgSIctrT SHOLL.avg.%s.value];', listctrT{i}));
    eval(sprintf('tempValues = SHOLL.raw.%s(:,2);', listctrT{i}));
    if numel(tempValues) > 150
        tempValues(150:end) = [];
    else 
        tempValues(end:tmpMaxDist) = NaN;
    end 
    
    SIctrT = [SIctrT; tempValues'];
end 

avgSIctrN = [];
SIctrN = [];
for i=1:numel(listctrN)
    eval(sprintf('SHOLL.avg.%s.value = mean(SHOLL.raw.%s(:,2));', listctrN{i},listctrN{i}));
    eval(sprintf('SHOLL.avg.%s.type = ''WT Nasal'';', listctrN{i}));
    eval(sprintf('avgSIctrN = [avgSIctrN SHOLL.avg.%s.value];', listctrN{i}));
    eval(sprintf('tempValues = SHOLL.raw.%s(:,2);', listctrN{i}));
    if numel(tempValues) > 150
        tempValues(151:end) = [];
    else 
        tempValues(end:tmpMaxDist) = NaN;
    end 
    SIctrN = [SIctrN; tempValues'];
end 

avgSIDT = [];
SIDT = [];
for i=1:numel(listDT)
    eval(sprintf('SHOLL.avg.%s.value = mean(SHOLL.raw.%s(:,2));', listDT{i},listDT{i}));
    eval(sprintf('SHOLL.avg.%s.type = ''DTR Temporal'';', listDT{i}));
    eval(sprintf('avgSIDT = [avgSIDT SHOLL.avg.%s.value];', listDT{i}));
    eval(sprintf('tempValues = SHOLL.raw.%s(:,2);', listDT{i}));
    if numel(tempValues) > 150
        tempValues(151:end) = [];
    else 
        tempValues(end:tmpMaxDist) = NaN;
    end 
    SIDT = [SIDT; tempValues'];
end 

avgSIDN = [];
SIDN = [];
for i=1:numel(listDN)
    eval(sprintf('SHOLL.avg.%s.value = mean(SHOLL.raw.%s(:,2));', listDN{i},listDN{i}));
    eval(sprintf('SHOLL.avg.%s.type = ''DTR Nasal'';', listDN{i}));
    eval(sprintf('avgSIDN = [avgSIDN SHOLL.avg.%s.value];', listDN{i}));
    eval(sprintf('tempValues = SHOLL.raw.%s(:,2);', listDN{i}));
    if numel(tempValues) > 150
        tempValues(151:end) = [];
    else 
        tempValues(end:tmpMaxDist) = NaN;
    end 
    SIDN = [SIDN; tempValues'];
end 

% Average values and statistical comparisons
ctrTSEM = std(avgSIctrT)/sqrt(numel(avgSIctrT));
ctrNSEM = std(avgSIctrN)/sqrt(numel(avgSIctrN));
DTSEM = std(avgSIDT)/sqrt(numel(avgSIDT));
DNSEM = std(avgSIDN)/sqrt(numel(avgSIDN));

if plotmode == 1
%% Plotting 

%Defining Colors
primary1 = [166/255,206/255,227/255];
secondary1  = [31/255,120/255,180/255];
primary2 = [178/255,223/255,138/255];
secondary2 = [51/255,160/255,44/255];
primary3 = [251/255,154/255,153/255];
secondary3 = [227/255,26/255,28/255];
primary4 = [253/255,191/255,111/255];
secondary4 = [255/255,127/255,0/255];

shollH = figure('Name', 'Sholl Analysis');
set(shollH, 'Position', [100 200 1600 500]);

set(gcf, 'DefaultAxesFontName', 'Arial');
set(gcf, 'DefaultTextFontSize', 16);
set(gcf, 'DefaultAxesFontName', 'Arial')
set(gcf, 'DefaultAxesFontSize', 16)
%plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor',color, 'FaceAlpha', 0.25, 'HandleVisibility', 'off');
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor','none', 'FaceAlpha', 0.25, 'HandleVisibility', 'off');
%whitebg(gcf);

%Plot control density 1
subplot('position', [0.06 0.12 0.5 0.8]);
hold on;
tmpY = nanmean(SIctrT);
numNonNans = nnz(~isnan(tmpY));
tmpX = [1:1:numNonNans];
margin = nanstd(SIctrT)/sqrt(size(SIctrT,1));
%plot(nanmean(SIctrT) + nanstd(SIctrT)/sqrt(size(SIctrT,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(SIctrT) - nanstd(SIctrT)/sqrt(size(SIctrT,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY(1:numNonNans)-margin(1:numNonNans),tmpY(1:numNonNans)+margin(1:numNonNans),primary1);
plot(tmpY, 'Color', secondary1, 'MarkerSize', 8);

%Plot control density 2
tmpY = nanmean(SIctrN);
numNonNans = nnz(~isnan(tmpY));
tmpX = [1:1:numNonNans];
margin = nanstd(SIctrN)/sqrt(size(SIctrN,1));
%plot(nanmean(SIctrN) + nanstd(SIctrN)/sqrt(size(SIctrN,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(SIctrN) - nanstd(SIctrN)/sqrt(size(SIctrN,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY(1:numNonNans)-margin(1:numNonNans),tmpY(1:numNonNans)+margin(1:numNonNans),primary2);
plot(tmpY, 'Color', secondary2,'MarkerSize', 8);

%Plot treated 1 density
tmpY = nanmean(SIDT);
numNonNans = nnz(~isnan(tmpY));
tmpX = [1:1:numNonNans];
margin = nanstd(SIDT)/sqrt(size(SIDT,1));
%plot(nanmean(SIDT) + nanstd(SIDT)/sqrt(size(SIDT,1)), 'r', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(SIDT) - nanstd(SIDT)/sqrt(size(SIDT,1)), 'r', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY(1:numNonNans)-margin(1:numNonNans),tmpY(1:numNonNans)+margin(1:numNonNans),primary3);
plot(tmpY, 'Color',secondary3, 'MarkerSize', 8);

%Plot treated 2 density
tmpY = nanmean(SIDN);
numNonNans = nnz(~isnan(tmpY));
tmpX = [1:1:numNonNans];
margin = nanstd(SIDN)/sqrt(size(SIDN,1));
%plot(nanmean(SIDN) + nanstd(SIDN)/sqrt(size(SIDN,1)), 'g', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(SIDN) - nanstd(SIDN)/sqrt(size(SIDN,1)), 'g', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY(1:numNonNans)-margin(1:numNonNans),tmpY(1:numNonNans)+margin(1:numNonNans),primary4);
plot(tmpY, 'Color',secondary4, 'MarkerSize', 8);

%Graphic adjustments
box off;
title('No. Sholl Intersections Along Distance from Soma');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0 tmpMaxDist]);
%ylim([0 1]);
xlabel('Distance from soma (µm)');
ylabel('Number of Sholl Intersections');
legend({'WT Temporal','WT Nasal', 'DTR Temporal', 'DTR Nasal'})
    
%Plot average density
subplot('position', [0.61 0.56 0.17 0.4]);
hold on;
tmpH = bar([1:4], [mean(avgSIctrT) mean(avgSIctrN), mean(avgSIDT), mean(avgSIDN)], 'k');
set(tmpH,'FaceColor','none')

errorbar(1, mean(avgSIctrT), std(avgSIctrT)/sqrt(numel(avgSIctrT)), 'Color',secondary1);
errorbar(2, mean(avgSIctrN), std(avgSIctrN)/sqrt(numel(avgSIctrN)), 'Color',secondary2);
errorbar(3, mean(avgSIDT), std(avgSIDT)/sqrt(numel(avgSIDT)), 'Color',secondary3);
errorbar(4, mean(avgSIDN), std(avgSIDN)/sqrt(numel(avgSIDN)), 'Color',secondary4);

for i=1:numel(avgSIctrT)
    plot(1,avgSIctrT(i),'Marker','o','Color',primary1,'MarkerSize', 8);
end
for i=1:numel(avgSIctrN)
    plot(2,avgSIctrN(i),'Marker','o','Color',primary2,'MarkerSize', 8);
end
for i=1:numel(avgSIDT)
    plot(3,avgSIDT(i),'Marker','o','Color',primary3,'MarkerSize', 8);
end
 for i=1:numel(avgSIDN)
     plot(4,avgSIDN(i),'Marker','o','Color',primary4,'MarkerSize', 8);
 end

box off;
title('Average Dendrite Complexity');
set(get(gca, 'title'),'Units','normalized')
set(get(gca, 'title'),'Position',[0.5 1.025 0])
set(gca, 'color', 'none',  'TickDir','out');
xlim([0.5 4.5]);
%ylim([0 1]);
set(gca,'XTick',[1 2 3 4]);
set(gca,'xtickLabel',{'WT T', 'WT N', 'DTR T', 'DTR N'});
ylabel('Number of Sholl Intersections');
        
elseif plotmode==2
%% 
primary1 = [64,64,64]./255;
secondary1  = [186,186,186]./255;
primary2 = [202,0,32]./255;
secondary2 = [244,165,130]./255;

shollH = figure('Name', 'Sholl Analysis');
set(shollH, 'Position', [100 200 1600 500]);

set(gcf, 'DefaultAxesFontName', 'Arial');
set(gcf, 'DefaultTextFontSize', 16);
set(gcf, 'DefaultAxesFontName', 'Arial')
set(gcf, 'DefaultAxesFontSize', 16)
%plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor',color, 'FaceAlpha', 0.25, 'HandleVisibility', 'off');
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor','none', 'FaceAlpha', 0.4, 'HandleVisibility', 'off');
%whitebg(gcf);

%TOP PLOT
subplot('position', [0.06 0.56 0.5 0.4]);
hold on;
tmpY = nanmean(SIctrT);
numNonNans = nnz(~isnan(tmpY));
tmpX = [1:1:numNonNans];
margin = nanstd(SIctrT)/sqrt(size(SIctrT,1));
%plot(nanmean(SIctrT) + nanstd(SIctrT)/sqrt(size(SIctrT,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(SIctrT) - nanstd(SIctrT)/sqrt(size(SIctrT,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY(1:numNonNans)-margin(1:numNonNans),tmpY(1:numNonNans)+margin(1:numNonNans),secondary1);
plot(tmpY, 'Color', primary1, 'MarkerSize', 8);

%Plot treated 1 density
tmpY = nanmean(SIDT);
numNonNans = nnz(~isnan(tmpY));
tmpX = [1:1:numNonNans];
margin = nanstd(SIDT)/sqrt(size(SIDT,1));
%plot(nanmean(SIDT) + nanstd(SIDT)/sqrt(size(SIDT,1)), 'r', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(SIDT) - nanstd(SIDT)/sqrt(size(SIDT,1)), 'r', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY(1:numNonNans)-margin(1:numNonNans),tmpY(1:numNonNans)+margin(1:numNonNans),secondary2);
plot(tmpY, 'Color',primary2, 'MarkerSize', 8);

%Graphic adjustments
box off;
title('No. Sholl Intersections Along Distance from Soma');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0 tmpMaxDist]);
%ylim([0 1]);
%xlabel('Distance from soma (µm)');
ylabel('Number of Sholl Intersections');
legend({'Control', 'Cone Loss'});


%BOTTOM PLOT
%Nasal CTR
subplot('position', [0.06 0.08 0.5 0.4]);
hold on;
tmpY = nanmean(SIctrN);
numNonNans = nnz(~isnan(tmpY));
tmpX = [1:1:numNonNans];
margin = nanstd(SIctrN)/sqrt(size(SIctrN,1));
%plot(nanmean(SIctrN) + nanstd(SIctrN)/sqrt(size(SIctrN,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(SIctrN) - nanstd(SIctrN)/sqrt(size(SIctrN,1)), 'k', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY(1:numNonNans)-margin(1:numNonNans),tmpY(1:numNonNans)+margin(1:numNonNans),secondary1);
plot(tmpY, 'Color', primary1,'MarkerSize', 8);

%Nasal DTR
tmpY = nanmean(SIDN);
numNonNans = nnz(~isnan(tmpY));
tmpX = [1:1:numNonNans];
margin = nanstd(SIDN)/sqrt(size(SIDN,1));
%plot(nanmean(SIDN) + nanstd(SIDN)/sqrt(size(SIDN,1)), 'g', 'MarkerSize', 8, 'HandleVisibility', 'off');
%plot(nanmean(SIDN) - nanstd(SIDN)/sqrt(size(SIDN,1)), 'g', 'MarkerSize', 8, 'HandleVisibility', 'off');
plot_variance(tmpX,tmpY(1:numNonNans)-margin(1:numNonNans),tmpY(1:numNonNans)+margin(1:numNonNans),secondary2);
plot(tmpY, 'Color',primary2, 'MarkerSize', 8);

%Graphic adjustments
box off;
%title('No. Sholl Intersections Along Distance from Soma');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0 tmpMaxDist]);
%ylim([0 1]);
xlabel('Distance from soma (µm)');
ylabel('Number of Sholl Intersections');
legend({'Control', 'Cone Loss'});


%Plot average density
subplot('position', [0.61 0.56 0.17 0.4]);
hold on;
tmpH = bar([1:4], [mean(avgSIctrT), mean(avgSIDT) mean(avgSIctrN), mean(avgSIDN)], 'k');
set(tmpH,'FaceColor','none')

for i=1:numel(avgSIctrT)
    plot(1,avgSIctrT(i),'Marker','o','Color',secondary1,'MarkerSize', 8);
end
for i=1:numel(avgSIDT)
    plot(2,avgSIDT(i),'Marker','o','Color',secondary2,'MarkerSize', 8);
end
for i=1:numel(avgSIctrN)
    plot(3,avgSIctrN(i),'Marker','o','Color',secondary1,'MarkerSize', 8);
end
 for i=1:numel(avgSIDN)
     plot(4,avgSIDN(i),'Marker','o','Color',secondary2,'MarkerSize', 8);
 end
 
errorbar(1, mean(avgSIctrT), std(avgSIctrT)/sqrt(numel(avgSIctrT)), 'Color',primary1);
errorbar(2, mean(avgSIDT), std(avgSIDT)/sqrt(numel(avgSIDT)), 'Color',primary2);
errorbar(3, mean(avgSIctrN), std(avgSIctrN)/sqrt(numel(avgSIctrN)), 'Color',primary1);
errorbar(4, mean(avgSIDN), std(avgSIDN)/sqrt(numel(avgSIDN)), 'Color',primary2);

box off;
title('Average Dendrite Complexity');
set(get(gca, 'title'),'Units','normalized')
set(get(gca, 'title'),'Position',[0.5 1.025 0])
set(gca, 'color', 'none',  'TickDir','out');
xlim([0.5 4.5]);
%ylim([0 1]);
set(gca,'XTick',[1 2 3 4]);
set(gca,'xtickLabel',{'T Ctrl', 'T DTR', 'N Ctrl', 'N DTR'});
ylabel('Number of Sholl Intersections');

end 
