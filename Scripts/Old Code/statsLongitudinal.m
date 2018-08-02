%% Perform 3-way ANOVA (row=day, column=intensity, z=condition)
allValues   = cat(3, Control, Laser);
aLevels     = repmat(TimePoints', 1, size(allValues,2), size(allValues,3));
bLevels     = repmat(LightIntensities, size(allValues,1), 1, size(allValues,3));
cLevels     = cat(3, zeros(size(Control)), ones(size(Laser)));

[p,~,stats] = anovan(allValues(:), {aLevels(:),bLevels(:),cLevels(:)});

disp('-------------------- 3-way ANOVA  -------------------');
disp(['factor Time,            p = ' num2str(p(1))]);
disp(['factor Light Intensity, p = ' num2str(p(2))]);
disp(['factor Treatment,       p = ' num2str(p(3))]);
disp(' ');

%% Perform 2-way ANOVA separately for control data (row=day, column=intensity)
allValues   = Control;
aLevels     = repmat(TimePoints', 1, size(allValues,2), size(allValues,3));
bLevels     = repmat(LightIntensities, size(allValues,1), 1, size(allValues,3));
[p,~,stats] = anovan(allValues(:), {aLevels(:),bLevels(:)});

disp('-------------------- 2-way ANOVA: Control group --------------------');
disp(['Control group, factor Time,             p = ' num2str(p(1))]);
disp(['Control group, factor Light Intensity,  p = ' num2str(p(2))]);
disp(' ');
if p(1) < 0.05
    multcompare(stats,'Dimension',1, 'CType', 'bonferroni');
end

%% Perform 2-way ANOVA separately for Laser data (row=day, column=intensity)
allValues   = Laser;
aLevels     = repmat(TimePoints', 1, size(allValues,2), size(allValues,3));
bLevels     = repmat(LightIntensities, size(allValues,1), 1, size(allValues,3));
[p,~,stats] = anovan(allValues(:), {aLevels(:),bLevels(:)});

disp('--------------------- 2-way ANOVA: Laser group ---------------------');
disp(['Laser group, factor Time,               p = ' num2str(p(1))]);
disp(['Laser group, factor Light Intesity,     p = ' num2str(p(2))]);
disp(' ');
if p(1) < 0.05
    multcompare(stats,'Dimension',1, 'CType', 'bonferroni');
end

clear aLevels bLevels cLevels allValues p* stats ans