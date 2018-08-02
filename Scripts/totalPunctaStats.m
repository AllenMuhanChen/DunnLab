%Grabs the total amount of puncta for each cell of each group and averages,
%followed by stats. 

%UNCOMMENT this code if you are NOT running it within STATSMASTER.m
%Otherwise STATSMASTER provides this information. 
% listctrT = {'Y5e3Lc1','Y5e3Rc1','U4a5Rc1','U4a5Lc4','U4a5Lc3','U4a5Lc1','V4a1Lc1','V4a1Lc3','V3c2Rc1'};
% listctrN = {'Y5e6Lc1','Y5e6Lc2','U4a5Lc2','V4a1Lc2','V4a1Rc2','V4a1Rc3','V3c2Lc1'};
% listDT = {'H6a3Rc1','U4b3Lc3','U4b3Lc7','U4b3Rc3','U4b3Rc4','U4b3Rc5','U4b1Rc2'};
% listDN = {'H6a1Lc1','U4b3Lc1','U4b3Rc6','U4b3Rc8','B4e1Lc1','B4e1Lc2'};

TPctrT = [];
TPctrN = [];
TPDT = [];
TPDN = [];

% basefolder = uigetdir;
allmembers = dir(basefolder);
allmembers = struct2cell(allmembers);                   %converting the struct to a cell for easier manipulation
allDates = allmembers(1,:);                             %defining allnames as the cell of all of the folder names under the basefolder
removeindcs = find(contains(allDates,'.'));             %finding the indices of '.' and '..' which are hidden members that we need to remove
allDates(removeindcs) = [];   

for i=1:size(allDates,2)
    pathDate = fullfile(basefolder,allDates{i});
    allmembers = dir(pathDate);
    allmembers = struct2cell(allmembers); 
    allCells = allmembers(1,:);                             %defining allnames as the cell of all of the folder names under the basefolder
    removeindcs = find(contains(allCells,'.'));             %finding the indices of '.' and '..' which are hidden members that we need to remove
    allCells(removeindcs) = [];
    
    for j = 1:size(allCells,2)
        pathCell = fullfile(pathDate,allCells{j});
        allmembers = dir(pathCell);
        allmembers = struct2cell(allmembers);
        allFiles = allmembers(1,:);
        matches1 = strfind(allFiles,'Dots.mat');
        tf1 = any(vertcat(matches1{:}));
        matches2= strfind(allFiles, 'Filter.mat');
        tf2 = any(vertcat(matches2{:}));
        if tf1 && tf2
            %load(fullfile(pathCell, 'Dots.mat'));
            load(fullfile(pathCell, 'Filter.mat'));
            if sum(strcmp(listctrT, allCells{j})) > 0
                TPctrT = [TPctrT numel(find(Filter.passF))];
            elseif sum(strcmp(listctrN, allCells{j})) > 0
                TPctrN = [TPctrN numel(find(Filter.passF))];
            elseif sum(strcmp(listDT, allCells{j})) > 0
                TPDT = [TPDT numel(find(Filter.passF))];
            elseif sum(strcmp(listDN, allCells{j})) > 0
                TPDN = [TPDN numel(find(Filter.passF))];
            end
        end
    end
end
 
%% Stats
allValues = cat(2,TPctrT, TPctrN, TPDT, TPDN);

%Treatment: WT, DTR
aLevels = cell(size(allValues));
aLevels(:,1:size(TPctrT,2) + size(TPctrN,2)) = {'WT'};
aLevels(:,size(TPctrT,2) + size(TPctrN,2) + 1:size(aLevels,2)) = {'DTR'};

%Side: Temporal, Nasal
bLevels = cell(size(allValues));
vars = {'TPctrT', 'TPctrN', 'TPDT', 'TPDN'};
sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
prevlength = 0;
for i=1:4
    currentlength = eval(sprintf('size(%s,2)',vars{i}));
    bLevels(:,prevlength+1:prevlength+currentlength) = sides(i);
    prevlength = prevlength + currentlength;
end 

[PUNCTA.totalsynapsesANOVA.p,~,PUNCTA.totalsynapsesANOVA.stats] = anovan(allValues(:), {aLevels, bLevels(:)}, 'Display', 'off');
disp('--------------Total Synapses per Cell  --------------');
disp('-------------------- 2-way ANOVA  -------------------');
disp(['factor  Treatment,            p = ' num2str(PUNCTA.totalsynapsesANOVA.p(1))]);
disp(['factor  Location,             p = ' num2str(PUNCTA.totalsynapsesANOVA.p(2))]);
disp(' ');



%% Plot Total Synapse Number

if plotmode == 1
    set(0, 'currentfigure',punctaH)
    subplot('position', [0.825 0.56 0.17 0.4]);
    hold on;
    tmpH = bar([1:4], [nanmean(TPctrT) nanmean(TPctrN), nanmean(TPDT), nanmean(TPDN)], 'k');
    set(tmpH,'FaceColor','none')
    
    errorbar(1, nanmean(TPctrT), nanstd(TPctrT)/sqrt(numel(TPctrT)), 'Color',secondary1);
    errorbar(2, nanmean(TPctrN), nanstd(TPctrN)/sqrt(numel(TPctrN)), 'Color',secondary2);
    errorbar(3, nanmean(TPDT), nanstd(TPDT)/sqrt(numel(TPDT)), 'Color',secondary3);
    errorbar(4, nanmean(TPDN), nanstd(TPDN)/sqrt(numel(TPDN)), 'Color',secondary4);
    
    for i=1:numel(TPctrT)
        plot(1,TPctrT(i),'Marker','o','Color',primary1,'MarkerSize', 8);
    end
    for i=1:numel(TPctrN)
        plot(2,TPctrN(i),'Marker','o','Color',primary2,'MarkerSize', 8);
    end
    for i=1:numel(TPDT)
        plot(3,TPDT(i),'Marker','o','Color',primary3,'MarkerSize', 8);
    end
    for i=1:numel(TPDN)
        plot(4,TPDN(i),'Marker','o','Color',primary4,'MarkerSize', 8);
    end
    
    box off;
    title('Synapses per Cell');
    set(get(gca, 'title'),'Units','normalized')
    set(get(gca, 'title'),'Position',[0.5 1.025 0])
    set(gca, 'color', 'none',  'TickDir','out');
    xlim([0.5 4.5]);
    %ylim([0 1]);
    set(gca,'XTick',[1 2 3 4]);
    set(gca,'xtickLabel',{'WT T', 'WT N', 'DTR T', 'DTR N'});
    ylabel('Number of Synapses')
end