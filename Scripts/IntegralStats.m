integralPDctrT = trapz(tmpPDctrT');
integralPDctrN = trapz(tmpPDctrN');
integralPDDT = trapz(tmpPDDT');
integralPDDN = trapz(tmpPDDN');

allValues = cat(2,integralPDctrT, integralPDctrN, integralPDDT, integralPDDN);

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(integralPDctrT,2) + size(integralPDctrN,2)) = {'WT'};
aLevels(:,size(integralPDctrT,2) + size(integralPDctrN,2) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'integralPDctrT', 'integralPDctrN', 'integralPDDT', 'integralPDDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,2)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[PUNCTA.integralANOVA.p,~,PUNCTA.integralANOVA.stats] = anovan(allValues(:), {aLevels, bLevels(:)}, 'Display', 'off');
disp('------------Area Under Puncta Denssty  --------------');
disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(PUNCTA.integralANOVA.p(1))]);
disp(['factor  Location,             p = ' num2str(PUNCTA.integralANOVA.p(2))]);
disp(' ');

% figure; 
% [PUNCTA.integralANOVA.ttests.c PUNCTA.integralANOVA.ttests.m PUNCTA.integralANOVA.ttests.h PUNCTA.integralANOVA.ttests.gnames] = multcompare(PUNCTA.integralANOVA.stats,'Dimension', [1 2],'CType', 'bonferroni');
% title('TWO-WAY: Treatment & Location. Area Under Distance');
% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')

%% Plot Average Areas
set(0, 'currentfigure',punctaH)
subplot('position', [0.82 0.56 0.17 0.4]);
hold on;
tmpH = bar([1:4], [nanmean(integralPDctrT) nanmean(integralPDctrN), nanmean(integralPDDT), nanmean(integralPDDN)], 'k');
set(tmpH,'FaceColor','none')

errorbar(1, nanmean(integralPDctrT), nanstd(integralPDctrT)/sqrt(numel(integralPDctrT)), 'Color',secondary1);
errorbar(2, nanmean(integralPDctrN), nanstd(integralPDctrN)/sqrt(numel(integralPDctrN)), 'Color',secondary2);
errorbar(3, nanmean(integralPDDT), nanstd(integralPDDT)/sqrt(numel(integralPDDT)), 'Color',secondary3);
errorbar(4, nanmean(integralPDDN), nanstd(integralPDDN)/sqrt(numel(integralPDDN)), 'Color',secondary4);

for i=1:numel(integralPDctrT)
    plot(1,integralPDctrT(i),'Marker','o','Color',primary1,'MarkerSize', 8);
end
for i=1:numel(integralPDctrN)
    plot(2,integralPDctrN(i),'Marker','o','Color',primary2,'MarkerSize', 8);
end
for i=1:numel(integralPDDT)
    plot(3,integralPDDT(i),'Marker','o','Color',primary3,'MarkerSize', 8);
end
 for i=1:numel(integralPDDN)
     plot(4,integralPDDN(i),'Marker','o','Color',primary4,'MarkerSize', 8);
 end

box off;
title('Area Under Curve');
set(get(gca, 'title'),'Units','normalized')
set(get(gca, 'title'),'Position',[0.5 1.025 0])
set(gca, 'color', 'none',  'TickDir','out');
xlim([0.5 4.5]);
%ylim([0 1]);
set(gca,'XTick',[1 2 3 4]);
set(gca,'xtickLabel',{'WT T', 'WT N', 'DTR T', 'DTR N'});
%ylabel('PSD95 Density (puncta/µm)');