%%
allValues = cat(2,tmpPDctr1', tmpPDctr2', tmpPDtreat1', tmpPDtreat2');

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(tmpPDctr1,1) + size(tmpPDctr2,1)) = {'WT'};
aLevels(:,size(tmpPDctr1,1) + size(tmpPDctr2,1) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'tmpPDctr1', 'tmpPDctr2', 'tmpPDtreat1', 'tmpPDtreat2'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,1)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

%Distance from Soma
cLevels = repmat((1:tmpMaxDist),size(allValues,2),1)';


[p,~,stats] = anovan(allValues(:), {aLevels(:),bLevels(:)}, 'varnames', {'Treatment', 'Location'});

disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(p(1))]);
disp(['factor  Location,             p = ' num2str(p(2))]);
disp(' ');

%% Perform 2-way ANOVA separately for control data (row=day, column=intensity)
% if p(1) < 0.05
%     multcompare(stats,'Dimension',1, 'CType', 'bonferroni');
% end
figure;
[c,m,h,gnames] = multcompare(stats, 'Dimension', [1 2], 'CType', 'bonferroni');

%% Digging for matched distances in multcompare 
matched = [];
for i=1:size(c,1)
    indices = [c(i,1) c(i,2)];
    for j=1:2
        if ~isempty(strfind(gnames{indices(j)},'Temporal'))
            locations{j} = 'Temporal';
        elseif ~isempty(strfind(gnames{indices(j)},'Nasal'))
            locations{j} = 'Nasal';
        end
        for k=1:2
            gnamesindex = regexp(gnames{indices(k)},'\d');
            distances(k) = str2num(gnames{indices(k)}(gnamesindex));
        end 
    end 
    
    if (distances(1)==distances(2))
        matched = [matched; c(i,1:end)];
    end 
    
    
end 

%% Iterative t-tests : %DTR Temporal T-Test vs DTR Nasal
TTESTS.DT_DN.h = [];
TTESTS.DT_DN.p = [];
TTESTS.DT_DN.ci = [];
TTESTS.DT_DN.stats = [];
for i=1:tmpMaxDist
    [tmph, tmpp, tmpci, tmpstats]= ttest2(tmpPDtreat1(:,i),tmpPDtreat2(:,i));      
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
    [tmph, tmpp, tmpci, tmpstats]= ttest2(tmpPDtreat1(:,i),tmpPDctr1(:,i));      
    TTESTS.DT_WT.h = [TTESTS.DT_WT.h tmph];
    TTESTS.DT_WT.p = [TTESTS.DT_WT.p tmpp];
    TTESTS.DT_WT.ci = [TTESTS.DT_WT.ci tmpci];
    TTESTS.DT_WT.stats = [TTESTS.DT_WT.stats tmpstats];
end 

