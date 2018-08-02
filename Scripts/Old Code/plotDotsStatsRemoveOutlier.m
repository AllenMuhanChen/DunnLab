%% THREE-WAY ANOVA: OUTLIER NOT REMOVED
allValues = cat(2,tmpPDctrT', tmpPDctrN', tmpPDDT', tmpPDDN');

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(tmpPDctrT,1) + size(tmpPDctrN,1)) = {'WT'};
aLevels(:,size(tmpPDctrT,1) + size(tmpPDctrN,1) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'tmpPDctrT', 'tmpPDctrN', 'tmpPDDT', 'tmpPDDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,1)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

%Distance from Soma
cLevels = repmat((1:tmpMaxDist),size(allValues,2),1)';


[p,~,stats] = anovan(allValues(:), {aLevels(:),bLevels(:),cLevels(:)}, 'varnames', {'Treatment', 'Location', 'Distance'}, 'continuous', 3);

disp('-------------------- 3-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(p(1))]);
disp(['factor  Location,             p = ' num2str(p(2))]);
disp(['factor  Distance,             p = ' num2str(p(3))]);
disp(' ');

figure; 
multcompare(stats,'Dimension',[2], 'CType', 'bonferroni');
title('THREE-WAY: Location shown only. OUTLIER NOT REMOVED');

%% TWO-WAY ANOVA: TREATMENT & LOCATION: OUTLIER NOT REMOVED
allValues = cat(2,tmpPDctrT', tmpPDctrN', tmpPDDT', tmpPDDN');

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(tmpPDctrT,1) + size(tmpPDctrN,1)) = {'WT'};
aLevels(:,size(tmpPDctrT,1) + size(tmpPDctrN,1) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'tmpPDctrT', 'tmpPDctrN', 'tmpPDDT', 'tmpPDDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,1)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 
%Distance from Soma
%cLevels = repmat((1:tmpMaxDist),size(allValues,2),1)';

[p,~,stats] = anovan(allValues(:), {aLevels(:),bLevels(:)});

disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,             p = ' num2str(p(1))]);
disp(['factor  Location,             p = ' num2str(p(2))]);
disp(' ');

figure; 
multcompare(stats,'Dimension',[1 2], 'CType', 'bonferroni');
title('TWO-WAY: Treatment & Location. OUTLIER NOT REMOVED');
% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')
%% TWO-WAY ANOVA: LOCATION & DISTANCE: OUTLIER NOT REMOVED
allValues = cat(2,tmpPDctrT', tmpPDctrN', tmpPDDT', tmpPDDN');

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'tmpPDctrT', 'tmpPDctrN', 'tmpPDDT', 'tmpPDDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,1)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 
%Distance from Soma
cLevels = repmat((1:tmpMaxDist),size(allValues,2),1)';

[p,~,stats] = anovan(allValues(:), {bLevels(:),cLevels(:)},'continuous', [2]);

disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Location,             p = ' num2str(p(1))]);
disp(['factor  Distance,             p = ' num2str(p(2))]);
disp(' ');

figure; 
multcompare(stats,'Dimension',[1], 'CType', 'bonferroni');
title('TWO-WAY: Location & Distance. OUTLIER NOT REMOVED');
% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')


%% ONE-WAY ANOVA: LOCATION: OUTLIER NOT REMOVED
allValues = cat(2,tmpPDctrT', tmpPDctrN', AvgPDDT', tmpPDDN');

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'tmpAvgPDctrT', 'tmpAvgPDctrN', 'tmpAvgPDDT', 'tmpAvgPDDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,1)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[p,~,stats] = anovan(allValues(:), {bLevels(:)});

disp('-------------------- 1-way ANOVA  -------------------');
disp(['factor  Location,             p = ' num2str(p(1))]);
disp(' ');

figure; 
multcompare(stats,'CType', 'bonferroni');
title('ONE-WAY: Location. OUTLIER NOT REMOVED');
% figure;
% [c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER NOT REMOVED')















%% OUTLIER REMOVED
allValues = cat(2,tmpPDctrT', tmpPDctrN', tmpPDDT_OUTLIER', tmpPDDN');

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(tmpPDctrT,1) + size(tmpPDctrN,1)) = {'WT'};
aLevels(:,size(tmpPDctrT,1) + size(tmpPDctrN,1) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'tmpPDctrT', 'tmpPDctrN', 'tmpPDDT_OUTLIER', 'tmpPDDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,1)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

%Distance from Soma
cLevels = repmat((1:tmpMaxDist),size(allValues,2),1)';


[p_OUTLIER,~,stats_OUTLIER] = anovan(allValues(:), {aLevels(:),bLevels(:),cLevels(:)}, 'varnames', {'Treatment', 'Location', 'Distance'}, 'continuous', 3);

disp('-------------------- 3-way ANOVA OUTLIER REMOVED  -------------------');
disp(['factor  Treatment,            p = ' num2str(p_OUTLIER(1))]);
disp(['factor  Location,             p = ' num2str(p_OUTLIER(2))]);
disp(['factor  Distance,             p = ' num2str(p_OUTLIER(3))]);
disp(' ');

%% Perform 2-way ANOVA separately for control data (row=day, column=intensity) OUTLIER REMOVED
allValues = cat(2,tmpAvgPDctrT', tmpAvgPDctrN', tmpAvgPDDT_OUTLIER', tmpAvgPDDN');

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(tmpAvgPDctrT,1) + size(tmpAvgPDctrN,1)) = {'WT'};
aLevels(:,size(tmpAvgPDctrT,1) + size(tmpAvgPDctrN,1) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'tmpAvgPDctrT', 'tmpAvgPDctrN', 'tmpAvgPDDT_OUTLIER', 'tmpAvgPDDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,1)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[p_OUTLIER,~,stats_OUTLIER] = anovan(allValues(:), {aLevels(:),bLevels(:)});

disp('-------------------- 2-way ANOVA OUTLIER REMOVED  -------------------');
disp(['factor  Treatment,            p = ' num2str(p_OUTLIER(1))]);
disp(['factor  Location,             p = ' num2str(p_OUTLIER(2))]);
disp(' ');
% figure;
% [c_OUTLIER,m_OUTLIER,h_OUTLIER,gnames_OUTLIER] = multcompare(stats_OUTLIER, 'Dimension', [1 2], 'CType', 'bonferroni');
% title('OUTLIER REMOVED')







% %% Digging for matched distances in multcompare 
% matched = [];
% for i=1:size(c,1)
%     indices = [c(i,1) c(i,2)];
%     for j=1:2
%         if ~isempty(strfind(gnames{indices(j)},'Temporal'))
%             locations{j} = 'Temporal';
%         elseif ~isempty(strfind(gnames{indices(j)},'Nasal'))
%             locations{j} = 'Nasal';
%         end
%         for k=1:2
%             gnamesindex = regexp(gnames{indices(k)},'\d');
%             distances(k) = str2num(gnames{indices(k)}(gnamesindex));
%         end 
%     end 
%     
%     if (distances(1)==distances(2))
%         matched = [matched; c(i,1:end)];
%     end 
%     
%     
% end 

%% Iterative t-tests : %DTR Temporal T-Test vs DTR Nasal
TTESTS.DT_DN.h = [];
TTESTS.DT_DN.p = [];
TTESTS.DT_DN.ci = [];
TTESTS.DT_DN.stats = [];
for i=1:tmpMaxDist
    [tmph, tmpp, tmpci, tmpstats]= ttest2(tmpPDDT_OUTLIER(:,i),tmpPDDN(:,i));      
    TTESTS.DT_DN.h = [TTESTS.DT_DN.h tmph];
    TTESTS.DT_DN.p = [TTESTS.DT_DN.p tmpp];
    TTESTS.DT_DN.ci = [TTESTS.DT_DN.ci tmpci];
    TTESTS.DT_DN.stats = [TTESTS.DT_DN.stats tmpstats];
end 

%% Iterative t-tests: DTR Temporal vs WT Temporal
TTESTS.DT_WT.h = [];
TTESTS.DT_WT.p = [];
TTESTS.DT_WT.ci = [];
TTESTS.DT_WT.stats = [];
for i=1:tmpMaxDist
    [tmph, tmpp, tmpci, tmpstats]= ttest2(tmpPDDT(:,i),tmpPDctrT(:,i));      
    TTESTS.DT_WT.h = [TTESTS.DT_WT.h tmph];
    TTESTS.DT_WT.p = [TTESTS.DT_WT.p tmpp];
    TTESTS.DT_WT.ci = [TTESTS.DT_WT.ci tmpci];
    TTESTS.DT_WT.stats = [TTESTS.DT_WT.stats tmpstats];
end 

