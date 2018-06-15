% Stats Tool for non-parametric statistical analyses of behavioural and non-EEG data; 
% Antonio Luque Casado % 03-April-2017%% 

%(std_stat, statcond and fdr_bh functions)
% fdr_bh function must be added to the path.

% Behavioural Stats: (mean data x subject) for each group/condition...
% Example: For a mixed design of 2 (group) x 2(condition), a cell array 2
% rows (Block 1 and Block2) and 2 columns (High-fit and Low-fit) is needed.
% Each cell must contains data for each group and condition (mean data x
% subject).

%% std_stat function (for Mixed between and within-subjects designs). FDR correction for multiple comparisons. 
[pcond, pgroup, pinter, statscond, statsgroup, statsinter] = std_stat(data, 'groupstats','on',...
    'condstats','on','method','perm','mcorrect','fdr','mode','eeglab','alpha',NaN,...
    'paired',{'on' 'off'},'naccu',200);

%% statcond function 2-way ANOVA permutations (for within-subjects designs with more than one factor)--> Not corrected
[stats, df, pvals, surrog] = statcond(HR, 'method', 'perm', 'structoutput', 'on', 'naccu', 10000);
display (pvals); display (' Block Effect    TramadolEffect     Inter');


%% Post-hoc Comparisons (When needed)
% t-test paired samples (non-parametric permutations)
 
DV = HR;  %% change it to the name of the variable to compare.

comps = {};
comps {1,1} = DV (1, :);
comps {1,2} = DV (2, :);

%% Loop for the "n" comparisons of interest of the VD

for i=1:length (comps);
    [t df pvals surog] = statcond(comps{1,i}, 'method', 'perm', 'naccu', 10000);
    
    pvalsstorage (i,1) = pvals;
    dfstorage (i,1) = df;
    tvalsstorage (i,1) = t;
    
end

%% FDR correction for multiple comparisons
pvals = pvalsstorage
[h, crit_p, adj_ci_cvrg, adj_p] = fdr_bh (pvals, 0.05, 'pdep', 'yes');
