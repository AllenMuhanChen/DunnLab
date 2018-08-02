%Takes a path as input (i.e C:\Users\Saturn\Desktop\Allen\Analysis) that
%has date folders that contain individual cell data file folders, and then loads sholl data from each
%individual data folder. (reads Skeleton_Sholl.csv or Skeleton_Sholl.xls
%from results folder)

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
        removeindcs = find(contains(allFiles,'.'));
        allFiles(removeindcs) = [];
        
        if sum(ismember(allFiles, 'results'))>0
            allmembers = dir(fullfile(pathCell,'results'));
            allmembers = struct2cell(allmembers);
            allResults = allmembers(1,:);
            
            matches = strfind(allResults,'Skeleton_Sholl');
            tf = any(vertcat(matches{:}));
            
            if tf
                if sum(ismember(allResults,'Skeleton_Sholl.csv'))
                    tmpraw = csvread(cat(2, pathCell, '\', 'results\Skeleton_Sholl.csv'));
                elseif sum(ismember(allResults,'Skeleton_Sholl.xls'))
                    tmpraw = xlsread(cat(2, pathCell, '\', 'results\Skeleton_Sholl.xls'));
                end
                
                eval(sprintf('SHOLL.raw.%s = %s;', allCells{j}, 'tmpraw'));
                clear allResults
            end
        end
    end
end

