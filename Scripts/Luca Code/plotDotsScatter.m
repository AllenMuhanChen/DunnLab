%% 
% ------------------------------------------------------
%   Raster plot of Imaris-passing dots (old style)
% user needs to provide SG, Dots, Settings
% ------------------------------------------------------
%  dots have intensity=1, background intensity=0)
% ------------------------------------------------------

A = zeros(Settings.ImInfo.yNumVox, Settings.ImInfo.xNumVox, Settings.ImInfo.zNumVox, 'uint8');

for i=1:Dots.Num;
    if SG.passI(i)
        A(Dots.Vox(i).Ind)=1;
    end
end

LDSmat2tif(A);
clear A

%% 
% ------------------------------------------------------
%   Scatter plot of Imaris-passing dots
% ------------------------------------------------------
% user needs to provide SG, Dots, Settings
% you can save plot as pdf for vector use in illustrator
% ------------------------------------------------------
% bug: when exporting in pdf, circles are drawn as hectagons
% ------------------------------------------------------

%Populate tmpA with passing dots locations [X Y Z]
tmpPassingDots = find(SG.passI);
tmpA = zeros(numel(tmpPassingDots), 3);

for i=1:numel(tmpPassingDots)
    tmpA(i,:)= mean(Dots.Vox(tmpPassingDots(i)).Pos);
end

scatter(tmpA(:,1), tmpA(:,2), 25, 'filled', 'k', 'o');
xlim([0 Settings.ImInfo.xNumVox]);
ylim([0 Settings.ImInfo.yNumVox]);
box on;
set(gca, 'xtick', []);
set(gca, 'ytick', []);

%clear i ans tmp*;
%% 
% ------------------------------------------------------
%   Plot 2D projecton of the skeleton on screen
% ------------------------------------------------------
% user needs to provide Skel, Settings
% you can save plot as pdf for vector use in illustrator
% ------------------------------------------------------
figure();
hold on;

%connect skeleton points 2 at a time with a line, points ID to connect are
%stored in couples inside Skel.FilStats.aEdges, coordinates of each ID are
%stored inside Skel.FilStats.aEdges as [X Y Z]

for i=1:numel(Skel.FilStats.aEdges)/2-1
    tmpID1 = Skel.FilStats.aEdges(i,1)+1; %+1 because imaris indices start with zero while matlabs with 1
    tmpID2 = Skel.FilStats.aEdges(i,2)+1; %+1 because imaris indices start with zero while matlabs with 1
    tmpX = [Skel.FilStats.aXYZ(tmpID1,1)*10+20 Skel.FilStats.aXYZ(tmpID2,1)*10+20]; % XYZ Coordinates are stored smaller by a factor 10
    tmpY = [Skel.FilStats.aXYZ(tmpID1,2)*10+20 Skel.FilStats.aXYZ(tmpID2,2)*10+20]; % XYZ Coordinates are stored smaller by a factor 10
    plot(tmpX, tmpY, 'k-');    
end

xlim([0 Settings.ImInfo.xNumVox]);
ylim([0 Settings.ImInfo.yNumVox]);
%xlim([0 5000]);
%ylim([0 5000]);
box on;
set(gca, 'xtick', []);
set(gca, 'ytick', []);
pbaspect([1 1 1]);
clear i ans tmp*;

%%
% ------------------------------------------------------
%   Plot 2D projecton of the skeleton on screen - FIJI version
% ------------------------------------------------------
% user needs to provide Skel, Settings
% you can save plot as pdf for vector use in illustrator
% ------------------------------------------------------

% Select skeleton to plot
[stringYES] = listdlg('PromptString','Select a FIJI skeleton',...
                           'SelectionMode','single', 'ListString',who);     % Choose experiment to process from workspace
s=who;                                                                      % List available variables
exp_name=char(s(stringYES));                                                % Retrieve selected experiment name
tmpSkel=evalin('base',exp_name);                                              % Retrieve selected experiment data
clear channelStr chStrID stringYES s;                                       % Cleanings


figure();
hold on;

%connect skeleton points 2 at a time with a line, points ID to connect are
%stored in couples inside Skel.FilStats.aEdges, coordinates of each ID are
%stored inside Skel.FilStats.aEdges as [X Y Z]

for i=1:numel(tmpSkel.branches)
    tmpX = tmpSkel.branches(i).points(:,1);
    tmpY = tmpSkel.branches(i).points(:,2);
    plot(tmpX, tmpY, 'k-');            
end


%xlim([0 Settings.ImInfo.xNumVox]);
%ylim([0 Settings.ImInfo.yNumVox]);
%xlim([0 5000]);
%ylim([0 5000]);
box on;
set(gca, 'xtick', []);
set(gca, 'ytick', []);
pbaspect([1 1 1]);
clear i ans tmp*;