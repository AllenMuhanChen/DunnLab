%Runs a TWO-WAY ANOVA on each point (distance) and follows up with t-tests.
%Results of this analysis are outputted into the PUNCTA structure:
%PUNCTA>>pbpANOVA>>each row is the outcome of a different distance point. 

%TWO-WAY ANOVA Loop
for i=1:150
    allValues = cat(2,tmpPDctrT(:,i)',tmpPDctrN(:,i)',tmpPDDT(:,i)',tmpPDDN(:,i)');
    
    aLevels = cell(size(allValues));
    aLevels(:,1:size(tmpPDctrT,1) + size(tmpPDctrN,1)) = {'WT'};
    aLevels(:,size(tmpPDctrT,1) + size(tmpPDctrN,1) + 1:size(aLevels,2)) = {'DTR'};
    
    bLevels = cell(size(allValues));
    vars = {'tmpPDctrT', 'tmpPDctrN', 'tmpPDDT', 'tmpPDDN'};
    sides = {'Temporal', 'Nasal', 'Temporal', 'Nasal'};
    prevlength = 0;
    for j=1:4
        currentlength = eval(sprintf('size(%s,1);',vars{j}));
        bLevels(:,prevlength+1:prevlength+currentlength) = sides(j);
        prevlength = prevlength + currentlength;
    end
    
    [PUNCTA.pbpANOVA(i).p,~,PUNCTA.pbpANOVA(i).stats] = anovan(allValues(:), {aLevels(:),bLevels(:)}, 'varnames', {'Treatment', 'Location'}, 'Display', 'off');

% %Multcompare Code. Uncomment to use it to follow up with t-ttests. 
%     if PUNCTA.pbpANOVA(i).p(1) <= 0.05
%         figure;
%         [PUNCTA.pbpANOVA(i).ttests1.c PUNCTA.pbpANOVA(i).ttests1.m PUNCTA.pbpANOVA(i).ttests1.h PUNCTA.pbpANOVA(i).ttests1.gnames] = multcompare(PUNCTA.pbpANOVA(i).stats, 'Dimension', [1 2], 'CType', 'bonferroni');
%         title('TWO-WAY ANOVA: Treatment & Location. Point by Point');
%     end 
%     if PUNCTA.pbpANOVA(i).p(2) <= 0.05
%         figure;
%         [PUNCTA.pbpANOVA(i).ttests2.c PUNCTA.pbpANOVA(i).ttests2.m PUNCTA.pbpANOVA(i).ttests2.h PUNCTA.pbpANOVA(i).ttests2.gnames] = multcompare(PUNCTA.pbpANOVA(i).stats, 'Dimension', [1 2], 'CType', 'bonferroni');
%         title('TWO-WAY ANOVA: Treatment & Location. Point by Point');
%     end 
end 


