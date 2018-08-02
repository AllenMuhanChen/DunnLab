% Accumulate and plot puncta density, as result of DotFinder analysis.
% -------------------------------------------------------------------------
% Coded by: Luca Della Santina 
% Date: August 7th 2012


tmpVars=who;
tmpMaxDist = 150; %Maximal distance from soma to plot density
[tmpSel] = listdlg('PromptString','Choose Control', 'ListString', tmpVars);

tmpPDctrl = NaN(numel(tmpSel), tmpMaxDist);
for i=1:numel(tmpSel)
    tmpSkel=evalin('base',char(tmpVars(tmpSel(i))));
    if numel(tmpSkel.PoverDvsPathLength)>=tmpMaxDist
        tmpPDctrl(i, :) = tmpSkel.PoverDvsPathLength(1:tmpMaxDist);
    else
        tmpPDctrl(i, 1:numel(tmpSkel.PoverDvsPathLength)) = tmpSkel.PoverDvsPathLength(:);
    end
end
tmpAvgPDctrl = nanmean(tmpPDctrl,2);

[tmpSel] = listdlg('PromptString','Choose Treated 1', 'ListString', tmpVars);
tmpPDtreat1 = NaN(numel(tmpSel), tmpMaxDist);
for i=1:numel(tmpSel)
    tmpSkel=evalin('base',char(tmpVars(tmpSel(i))));
    if numel(tmpSkel.PoverDvsPathLength)>=tmpMaxDist
        tmpPDtreat1(i, :) = tmpSkel.PoverDvsPathLength(1:tmpMaxDist);
    else
        tmpPDtreat1(i, 1:numel(tmpSkel.PoverDvsPathLength)) = tmpSkel.PoverDvsPathLength(:);
    end
end
tmpAvgPDtreat1 = nanmean(tmpPDtreat1,2);

[tmpSel] = listdlg('PromptString','Choose Treated 2', 'ListString', tmpVars);
tmpPDtreat2 = NaN(numel(tmpSel), tmpMaxDist);
for i=1:numel(tmpSel)
    tmpSkel=evalin('base',char(tmpVars(tmpSel(i))));
    if numel(tmpSkel.PoverDvsPathLength)>=tmpMaxDist
        tmpPDtreat2(i, :) = tmpSkel.PoverDvsPathLength(1:tmpMaxDist);
    else
        tmpPDtreat2(i, 1:numel(tmpSkel.PoverDvsPathLength)) = tmpSkel.PoverDvsPathLength(:);
    end
end
tmpAvgPDtreat2 = nanmean(tmpPDtreat2,2);

% Average values and statistical comparisons
disp('-------------------------------------');
disp('Average density (dots/micron, SEM)   ');
disp('-------------------------------------');
disp(['Control: ' num2str(mean(tmpAvgPDctrl)) setstr(177) num2str(std(tmpAvgPDctrl)/sqrt(numel(tmpAvgPDctrl))) ' n=' num2str(numel(tmpAvgPDctrl))]);
disp(['Treat1: ' num2str(mean(tmpAvgPDtreat1)) setstr(177) num2str(std(tmpAvgPDtreat1)/sqrt(numel(tmpAvgPDtreat1))) ' n=' num2str(numel(tmpAvgPDtreat1))]);
disp(['Treat2: ' num2str(mean(tmpAvgPDtreat2)) setstr(177) num2str(std(tmpAvgPDtreat2)/sqrt(numel(tmpAvgPDtreat2))) ' n=' num2str(numel(tmpAvgPDtreat2))]);
disp(' ');
disp('-------------------------------------');
disp('Statistical comparison (ranksum test)');
disp('-------------------------------------');
tmpPc1 = ranksum(tmpAvgPDtreat1, tmpAvgPDctrl);
disp(sprintf('Avg density treat 1 vs ctrl.... p = %3.5f', tmpPc1));
tmpPc2 = ranksum(tmpAvgPDtreat2, tmpAvgPDctrl);
disp(sprintf('Avg density treat 2 vs ctrl.... p = %3.5f', tmpPc2));
tmpP12 = ranksum(tmpAvgPDtreat1, tmpAvgPDtreat2);
disp(sprintf('Avg density treat 1 vs treat 2.... p = %3.5f', tmpP12));


% Plot dot density
tmpH = figure('Name', 'Sholl analysis');
set(tmpH, 'Position', [100 200 1200 500]);

set(gcf, 'DefaultAxesFontName', 'Arial');
set(gcf, 'DefaultTextFontSize', 16);
set(gcf, 'DefaultAxesFontName', 'Arial')
set(gcf, 'DefaultAxesFontSize', 16)
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor',color);

%whitebg(gcf);

%Plot control density
subplot('position', [0.06 0.12 0.7 0.8]);
hold on;
tmpY = nanmean(tmpPDctrl);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDctrl)/sqrt(size(tmpPDctrl,1));
plot(nanmean(tmpPDctrl) + nanstd(tmpPDctrl)/sqrt(size(tmpPDctrl,1)), 'k', 'MarkerSize', 8);
plot(nanmean(tmpPDctrl) - nanstd(tmpPDctrl)/sqrt(size(tmpPDctrl,1)), 'k', 'MarkerSize', 8);
plot_variance(tmpX,tmpY-margin,tmpY+margin,[0.5 0.5 0.5])
plot(tmpY, 'k', 'MarkerSize', 8);

%Plot treated 1 density
tmpY = nanmean(tmpPDtreat1);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDtreat1)/sqrt(size(tmpPDtreat1,1));
plot(nanmean(tmpPDtreat1) + nanstd(tmpPDtreat1)/sqrt(size(tmpPDtreat1,1)), 'r', 'MarkerSize', 8);
plot(nanmean(tmpPDtreat1) - nanstd(tmpPDtreat1)/sqrt(size(tmpPDtreat1,1)), 'r', 'MarkerSize', 8);
plot_variance(tmpX,tmpY-margin,tmpY+margin,[0.5 0 0])
plot(tmpY, 'r', 'MarkerSize', 8);

%Plot treated 2 density
tmpY = nanmean(tmpPDtreat2);
tmpX = [1:1:numel(tmpY)];
margin = nanstd(tmpPDtreat2)/sqrt(size(tmpPDtreat2,1));
plot(nanmean(tmpPDtreat2) + nanstd(tmpPDtreat2)/sqrt(size(tmpPDtreat2,1)), 'g', 'MarkerSize', 8);
plot(nanmean(tmpPDtreat2) - nanstd(tmpPDtreat2)/sqrt(size(tmpPDtreat2,1)), 'g', 'MarkerSize', 8);
plot_variance(tmpX,tmpY-margin,tmpY+margin,[0 0.5 0])
plot(tmpY, 'g', 'MarkerSize', 8);

%Graphic adjustments
box off;
title('PSD95 density along dendrites');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0 tmpMaxDist]);
ylim([0 1]);
xlabel('Distance from soma (µm)');
ylabel('PSD95 density (puncta/µm)');

%Plot average density
subplot('position', [0.8 0.12 0.18 0.8]);
hold on;
tmpH = bar([1:3], [mean(tmpAvgPDctrl), mean(tmpAvgPDtreat1), mean(tmpAvgPDtreat2)], 'k');
set(tmpH,'FaceColor','none')

errorbar(1, mean(tmpAvgPDctrl), std(tmpAvgPDctrl)/sqrt(numel(tmpAvgPDctrl)), 'k');
errorbar(2, mean(tmpAvgPDtreat1), std(tmpAvgPDtreat1)/sqrt(numel(tmpAvgPDtreat1)), 'r');
errorbar(3, mean(tmpAvgPDtreat2), std(tmpAvgPDtreat2)/sqrt(numel(tmpAvgPDtreat2)), 'g');

for i=1:numel(tmpAvgPDctrl);
    plot(1,tmpAvgPDctrl(i),'--ok','MarkerSize', 8);
end
for i=1:numel(tmpAvgPDtreat1);
    plot(2,tmpAvgPDtreat1(i),'--or','MarkerSize', 8);
end
 for i=1:numel(tmpAvgPDtreat2);
     plot(3,tmpAvgPDtreat2(i),'--og','MarkerSize', 8);
 end

box off;
title('Average PSD95 density');
set(gca, 'color', 'none',  'TickDir','out');
xlim([0.5 3.5]);
ylim([0 1]);
set(gca,'XTick',[1 2 3]);
set(gca,'xtickLabel',{sprintf('Control (%d)', numel(tmpAvgPDctrl)),...
                      sprintf('DTR (%d)',   numel(tmpAvgPDtreat1))}),...
%                       sprintf('Beads (%d)',   numel(tmpAvgPDtreat2))});
text(1.75, 1.4, sprintf('p ctrl=\n%3.4f', tmpPc1));
text(2.75, 1.4, sprintf('p ctrl=\n%3.4f', tmpPc2));
%text(2.75, 1.2, sprintf('p vs 1=\n%3.4f', tmpP12));

%clear tmp* i margin plot_variance;