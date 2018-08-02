%Finds the distance of maximum puncta density along the dendrite, averages
%and runs stats (Two-Way ANOVA). Plots information as well. 

%%

[CVctrT DMctrT] = max(tmpPDctrT');
[CVctrN DMctrN] = max(tmpPDctrN');
[CVDT DMDT] = max(tmpPDDT');
[CVDN DMDN] = max(tmpPDDN');

%% DendriteMaximum
allValues = cat(2,DMctrT, DMctrN, DMDT, DMDN);

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(DMctrT,2) + size(DMctrN,2)) = {'WT'};
aLevels(:,size(DMctrT,2) + size(DMctrN,2) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'DMctrT', 'DMctrN', 'DMDT', 'DMDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,2)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[PUNCTA.dmANOVA.p,~,PUNCTA.dmANOVA.stats] = anovan(allValues(:), {aLevels, bLevels(:)}, 'Display', 'off');
disp('----------------Puncta Dendrite Maximum--------------');
disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(PUNCTA.dmANOVA.p(1))]);
disp(['factor  Location,             p = ' num2str(PUNCTA.dmANOVA.p(2))]);
disp(' ');

% figure; 
% [PUNCTA.dmANOVA.ttests.c PUNCTA.dmANOVA.ttests.m PUNCTA.dmANOVA.ttests.h PUNCTA.dmANOVA.ttests.gnames] = multcompare(PUNCTA.dmANOVA.stats,'Dimension', [1 2],'CType', 'bonferroni');
% title('TWO-WAY: Treatment & Location. Puncta Dendrite Maximum');
% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')


%% Plot Average Dendrite Maximums
if plotmode == 1
    set(0, 'currentfigure',punctaH)
    subplot('position', [0.61 0.04 0.17 0.4]);
    hold on;
    tmpH = bar([1:4], [nanmean(DMctrT) nanmean(DMctrN), nanmean(DMDT), nanmean(DMDN)], 'k');
    set(tmpH,'FaceColor','none')
    
    errorbar(1, nanmean(DMctrT), nanstd(DMctrT)/sqrt(numel(DMctrT)), 'Color',secondary1);
    errorbar(2, nanmean(DMctrN), nanstd(DMctrN)/sqrt(numel(DMctrN)), 'Color',secondary2);
    errorbar(3, nanmean(DMDT), nanstd(DMDT)/sqrt(numel(DMDT)), 'Color',secondary3);
    errorbar(4, nanmean(DMDN), nanstd(DMDN)/sqrt(numel(DMDN)), 'Color',secondary4);
    
    for i=1:numel(DMctrT)
        plot(1,DMctrT(i),'Marker','o','Color',primary1,'MarkerSize', 8);
    end
    for i=1:numel(DMctrN)
        plot(2,DMctrN(i),'Marker','o','Color',primary2,'MarkerSize', 8);
    end
    for i=1:numel(DMDT)
        plot(3,DMDT(i),'Marker','o','Color',primary3,'MarkerSize', 8);
    end
    for i=1:numel(DMDN)
        plot(4,DMDN(i),'Marker','o','Color',primary4,'MarkerSize', 8);
    end
    
    box off;
    title('Distance of Maximum Synapse Density');
    set(get(gca, 'title'),'Units','normalized')
    set(get(gca, 'title'),'Position',[0.5 1.025 0])
    set(gca, 'color', 'none',  'TickDir','out');
    xlim([0.5 4.5]);
    %ylim([0 1]);
    set(gca,'XTick',[1 2 3 4]);
    set(gca,'xtickLabel',{'WT T', 'WT N', 'DTR T', 'DTR N'});
    ylabel('Distance from Soma (µm)');
elseif plotmode == 2
    set(0, 'currentfigure',punctaH)
    subplot('position', [0.61 0.04 0.17 0.4]);
    hold on;
    tmpH = bar([1:4], [nanmean(DMctrT), nanmean(DMDT), nanmean(DMctrN), nanmean(DMDN)], 'k');
    set(tmpH,'FaceColor','none')

    for i=1:numel(DMctrT)
        plot(1,DMctrT(i),'Marker','o','Color',secondary1,'MarkerSize', 8);
    end
    for i=1:numel(DMDT)
        plot(2,DMDT(i),'Marker','o','Color',secondary2,'MarkerSize', 8);
    end
    for i=1:numel(DMctrN)
        plot(3,DMctrN(i),'Marker','o','Color',secondary1,'MarkerSize', 8);
    end
    for i=1:numel(DMDN)
        plot(4,DMDN(i),'Marker','o','Color',secondary2,'MarkerSize', 8);
    end
        
    errorbar(1, nanmean(DMctrT), nanstd(DMctrT)/sqrt(numel(DMctrT)), 'Color',primary1);
    errorbar(2, nanmean(DMDT), nanstd(DMDT)/sqrt(numel(DMDT)), 'Color',primary2);
    errorbar(3, nanmean(DMctrN), nanstd(DMctrN)/sqrt(numel(DMctrN)), 'Color',primary1);
    errorbar(4, nanmean(DMDN), nanstd(DMDN)/sqrt(numel(DMDN)), 'Color',primary2);
    
    box off;
    title('Distance of Maximum Synapse Density');
    set(get(gca, 'title'),'Units','normalized')
    set(get(gca, 'title'),'Position',[0.5 1.025 0])
    set(gca, 'color', 'none',  'TickDir','out');
    xlim([0.5 4.5]);
    %ylim([0 1]);
    set(gca,'XTick',[1 2 3 4]);
    set(gca,'xtickLabel',{'T Ctrl', 'T DTR', 'N Ctrl', 'N DTR'});
    ylabel('Distance from Soma (µm)');
end