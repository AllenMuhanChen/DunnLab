%Plots the maximum puncta density, averages and does stats (TWO-way ANOVA). 
%%
[CVctrT DMctrT] = max(tmpPDctrT');
[CVctrN DMctrN] = max(tmpPDctrN');
[CVDT DMDT] = max(tmpPDDT');
[CVDN DMDN] = max(tmpPDDN');
%% DendriteMaximum
allValues = cat(2,CVctrT, CVctrN, CVDT, CVDN);

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(CVctrT,2) + size(CVctrN,2)) = {'WT'};
aLevels(:,size(CVctrT,2) + size(CVctrN,2) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'CVctrT', 'CVctrN', 'CVDT', 'CVDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,2);',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[PUNCTA.cvANOVA.p,~,PUNCTA.cvANOVA.stats] = anovan(allValues(:), {aLevels, bLevels(:)}, 'Display', 'off');
disp('----------------Puncta Critical Value---------------');
disp('')
disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(PUNCTA.cvANOVA.p(1))]);
disp(['factor  Location,             p = ' num2str(PUNCTA.cvANOVA.p(2))]);
disp(' ');

% figure; 
% [PUNCTA.cvANOVA.ttests.c PUNCTA.cvANOVA.ttests.m PUNCTA.cvANOVA.ttests.h PUNCTA.cvANOVA.ttests.gnames] = multcompare(PUNCTA.cvANOVA.stats,'Dimension', [1 2],'CType', 'bonferroni');
% title('TWO-WAY: Treatment & Location. Puncta Dendrite Maximum');
% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')

%% Plot Average Max Densities
if plotmode == 1
    set(0, 'currentfigure',punctaH)
    subplot('position', [0.825 0.04 0.17 0.4]);
    hold on;
    tmpH = bar([1:4], [nanmean(CVctrT) nanmean(CVctrN), nanmean(CVDT), nanmean(CVDN)], 'k');
    set(tmpH,'FaceColor','none')
    
    errorbar(1, nanmean(CVctrT), nanstd(CVctrT)/sqrt(numel(CVctrT)), 'Color',secondary1);
    errorbar(2, nanmean(CVctrN), nanstd(CVctrN)/sqrt(numel(CVctrN)), 'Color',secondary2);
    errorbar(3, nanmean(CVDT), nanstd(CVDT)/sqrt(numel(CVDT)), 'Color',secondary3);
    errorbar(4, nanmean(CVDN), nanstd(CVDN)/sqrt(numel(CVDN)), 'Color',secondary4);
    
    for i=1:numel(CVctrT)
        plot(1,CVctrT(i),'Marker','o','Color',primary1,'MarkerSize', 8);
    end
    for i=1:numel(CVctrN)
        plot(2,CVctrN(i),'Marker','o','Color',primary2,'MarkerSize', 8);
    end
    for i=1:numel(CVDT)
        plot(3,CVDT(i),'Marker','o','Color',primary3,'MarkerSize', 8);
    end
    for i=1:numel(CVDN)
        plot(4,CVDN(i),'Marker','o','Color',primary4,'MarkerSize', 8);
    end
    
    box off;
    title('Maximum Synapse Density');
    set(get(gca, 'title'),'Units','normalized')
    set(get(gca, 'title'),'Position',[0.5 1.025 0])
    set(gca, 'color', 'none',  'TickDir','out');
    xlim([0.5 4.5]);
    %ylim([0 1]);
    set(gca,'XTick',[1 2 3 4]);
    set(gca,'xtickLabel',{'WT T', 'WT N', 'DTR T', 'DTR N'});
    ylabel('PSD95 Density (puncta/µm)');
elseif plotmode == 2
    set(0, 'currentfigure',punctaH)
    subplot('position', [0.825 0.04 0.17 0.4]);
    hold on;
    tmpH = bar([1:4], [nanmean(CVctrT), nanmean(CVDT), nanmean(CVctrN), nanmean(CVDN)], 'k');
    set(tmpH,'FaceColor','none')
    
    for i=1:numel(CVctrT)
        plot(1,CVctrT(i),'Marker','o','Color',secondary1,'MarkerSize', 8);
    end
    for i=1:numel(CVDT)
        plot(2,CVDT(i),'Marker','o','Color',secondary2,'MarkerSize', 8);
    end
    for i=1:numel(CVctrN)
        plot(3,CVctrN(i),'Marker','o','Color',secondary1,'MarkerSize', 8);
    end
    for i=1:numel(CVDN)
        plot(4,CVDN(i),'Marker','o','Color',secondary2,'MarkerSize', 8);
    end
    
    errorbar(1, nanmean(CVctrT), nanstd(CVctrT)/sqrt(numel(CVctrT)), 'Color',primary1);
    errorbar(2, nanmean(CVDT), nanstd(CVDT)/sqrt(numel(CVDT)), 'Color',primary2);
    errorbar(3, nanmean(CVctrN), nanstd(CVctrN)/sqrt(numel(CVctrN)), 'Color',primary1);
    errorbar(4, nanmean(CVDN), nanstd(CVDN)/sqrt(numel(CVDN)), 'Color',primary2);
    

    box off;
    title('Maximum Synapse Density');
    set(get(gca, 'title'),'Units','normalized')
    set(get(gca, 'title'),'Position',[0.5 1.025 0])
    set(gca, 'color', 'none',  'TickDir','out');
    xlim([0.5 4.5]);
    %ylim([0 1]);
    set(gca,'XTick',[1 2 3 4]);
    set(gca,'xtickLabel',{'T Ctrl', 'T DTR', 'N Ctrl', 'N DTR'});
    ylabel('PSD95 Density (puncta/µm)');
end
