%Takes a path as input (i.e C:\Users\Saturn\Desktop\Allen\Analysis) that
%has date folders that contain individual cell data file folders, and then loads PathLengthStats from each
%individual data folder

basefolder = uigetdir;
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
        matches = strfind(allFiles,'PathLengthStats');
        tf = any(vertcat(matches{:}));
        
        if tf
            load(fullfile(pathCell,'PathLengthStats'));
            temp_var = allCells{j};
            eval(sprintf('%s = %s;',temp_var,'PathLengthStats'));
            clear('PathLengthStats');
        end
    end 
end
clearvars -except -regexp \d$|basefolder %clearing all vars except for those that end in a number. 
