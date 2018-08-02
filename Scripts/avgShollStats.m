%% TWO-WAY ANOVA: TREATMENT & LOCATION. Sholl Number of Intersections
allValues = cat(2,avgSIctrT, avgSIctrN, avgSIDT, avgSIDN);

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(SIctrT,1) + size(SIctrN,1)) = {'WT'};
aLevels(:,size(SIctrT,1) + size(SIctrN,1) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'avgSIctrT', 'avgSIctrN', 'avgSIDT', 'avgSIDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,2);',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[SHOLL.avgANOVA.p,~,SHOLL.avgANOVA.stats] = anovan(allValues(:), {aLevels, bLevels(:)}, 'Display', 'off');
disp('----Sholl Intersections Averaged Across Distance-----')
disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(SHOLL.avgANOVA.p(1))]);
disp(['factor  Location,             p = ' num2str(SHOLL.avgANOVA.p(2))]);
disp(' ');

% figure; 
% [SHOLL.avgANOVA.ttests.c SHOLL.avgANOVA.ttests.m SHOLL.avgANOVA.ttests.h SHOLL.avgANOVA.ttests.gnames] = multcompare(SHOLL.avgANOVA.stats,'Dimension', [1 2],'CType', 'bonferroni');
% title('TWO-WAY: Treatment & Location. Sholl Intersetions Averaged Across Distance');
% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')


