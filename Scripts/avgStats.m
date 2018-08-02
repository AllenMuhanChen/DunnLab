%% TWO-WAY ANOVA: TREATMENT & LOCATION
%Runs a two-way ANOVA on average treatment versus location (ignoring position). 
allValues = cat(2,tmpAvgPDctrT', tmpAvgPDctrN', tmpAvgPDDT', tmpAvgPDDN');

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(tmpPDctrT,1) + size(tmpPDctrN,1)) = {'WT'};
aLevels(:,size(tmpPDctrT,1) + size(tmpPDctrN,1) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'tmpAvgPDctrT', 'tmpAvgPDctrN', 'tmpAvgPDDT', 'tmpAvgPDDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,1);',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[PUNCTA.avgANOVA.p,~,PUNCTA.avgANOVA.stats] = anovan(allValues(:), {aLevels, bLevels(:)}, 'Display', 'off');
disp('-----  Average Puncta Density Across Distance  ------');
disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(PUNCTA.avgANOVA.p(1))]);
disp(['factor  Location,             p = ' num2str(PUNCTA.avgANOVA.p(2))]);
disp(' ');

% figure; 
% [PUNCTA.avgANOVA.ttests.c PUNCTA.avgANOVA.ttests.m PUNCTA.avgANOVA.ttests.h PUNCTA.avgANOVA.ttests.gnames] = multcompare(PUNCTA.avgANOVA.stats,'Dimension', [1 2],'CType', 'bonferroni');
% title('TWO-WAY: Treatment & Location. Averaged Across Distance');

% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')


