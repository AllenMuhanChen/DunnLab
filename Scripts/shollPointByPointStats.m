%Runs a TWO-WAY ANOVA on each point (distance)


for i=1:150
    allValues = cat(2,SIctrT(:,i)',SIctrN(:,i)',SIDT(:,i)',SIDN(:,i)');
    
    aLevels = cell(size(allValues));
    aLevels(:,1:size(SIctrT,1) + size(SIctrN,1)) = {'WT'};
    aLevels(:,size(SIctrT,1) + size(SIctrN,1) + 1:size(aLevels,2)) = {'DTR'};
    
    bLevels = cell(size(allValues));
    vars = {'SIctrT', 'SIctrN', 'SIDT', 'SIDN'};
    sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
    prevlength = 0;
    for j=1:4
        currentlength = eval(sprintf('size(%s,1);',vars{j}));
        bLevels(:,prevlength+1:prevlength+currentlength) = sides(j);
        prevlength = prevlength + currentlength;
    end
    
    [SHOLL.pbpANOVA(i).p,~,SHOLL.pbpANOVA(i).stats] = anovan(allValues(:), {aLevels(:),bLevels(:)}, 'varnames', {'Treatment', 'Location'}, 'Display', 'off');
%     if nnz(~isnan(SHOLL.pbpANOVA(i).p)) == 2
%         if SHOLL.pbpANOVA(i).p(1) <= 0.05 && SHOLL.pbpANOVA(i).p(2) > 0.05
%             figure;
%             [SHOLL.pbpANOVA(i).ttests1.c SHOLL.pbpANOVA(i).ttests1.m SHOLL.pbpANOVA(i).ttests1.h SHOLL.pbpANOVA(i).ttests1.gnames] = multcompare(SHOLL.pbpANOVA(i).stats, 'Dimension', 1, 'CType', 'bonferroni');
%             title(['TWO-WAY ANOVA: Treatment. Point by Point' num2str(i)]);
%         elseif SHOLL.pbpANOVA(i).p(1) > 0.05 && SHOLL.pbpANOVA(i).p(2) <= 0.05
%             figure;
%             [SHOLL.pbpANOVA(i).ttests1.c SHOLL.pbpANOVA(i).ttests1.m SHOLL.pbpANOVA(i).ttests1.h SHOLL.pbpANOVA(i).ttests1.gnames] = multcompare(SHOLL.pbpANOVA(i).stats, 'Dimension', 2, 'CType', 'bonferroni');
%             title(['TWO-WAY ANOVA: Location. Point by Point' num2str(i)]);
%         elseif SHOLL.pbpANOVA(i).p(1) <= 0.05 && SHOLL.pbpANOVA(i).p(2) <= 0.05
%             [SHOLL.pbpANOVA(i).ttests1.c SHOLL.pbpANOVA(i).ttests1.m SHOLL.pbpANOVA(i).ttests1.h SHOLL.pbpANOVA(i).ttests1.gnames] = multcompare(SHOLL.pbpANOVA(i).stats, 'Dimension', [1 2], 'CType', 'bonferroni');
%             title(['TWO-WAY ANOVA: Treatment & Location. Point by Point' num2str(i)]);
%         end
%     end
end

