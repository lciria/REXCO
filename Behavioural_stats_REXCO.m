% Stats Tool for non-parametric statistical analyses of behavioural and non-EEG data; 
% Antonio Luque Casado % 03-April-2017%% 

%(std_stat, statcond and fdr_bh functions)
% fdr_bh function must be added to the path.

% Behavioural Stats: (mean data x subject) for each group/condition...
% Example: For a mixed design of 2 (group) x 2(condition), a cell array 2
% rows (Block 1 and Block2) and 2 columns (High-fit and Low-fit) is needed.
% Each cell must contains data for each group and condition (mean data x
% subject).

%  Outputs:
%  pcond        - [cell] condition pvalues or mask (0 or 1) if an alpha value
%                 is selected. One element per group.
%  pgroup       - [cell] group pvalues or mask (0 or 1). One element per 
%                 condition.
%  pinter       - [cell] three elements, condition pvalues (group pooled),
%                 group pvalues (condition pooled) and interaction pvalues.
%  statcond     - [cell] condition statistic values (F or T).
%  statgroup    - [cell] group pvalues or mask (0 or 1). One element per 
%                 condition.
%  statinter    - [cell] three elements, condition statistics (group pooled),
%                 group statistics (condition pooled) and interaction F statistics.

%% Create data matrix 2 (Moderate, Ligth) x 2 (Task1, Task2)
clear all; close all; clc;
%%%% Descriptive data
%load RT_CA_Cong_T1_LuisCiria_14-Sep-2017
load RT_CA_Incong_T1_LuisCiria_20-Sep-2017
data{1,1}=RT'; %CA_T1

%load RT_CB_Cong_T1_LuisCiria_14-Sep-2017
load RT_CB_Incong_T1_LuisCiria_14-Sep-2017
data{1,2}=RT'; %CB_T1

%load RT_CA_Cong_T2_LuisCiria_14-Sep-2017
load RT_CA_Incong_T2_LuisCiria_14-Sep-2017
data{2,1}=RT'; %CA_T2

%load RT_CB_Cong_T2_LuisCiria_14-Sep-2017
load RT_CB_Incong_T2_LuisCiria_14-Sep-2017
data{2,2}=RT'; %CB_T2

%% Congruency effect:  2(Moderate, Ligth) x 2(Task1, Task2)
clear all; close all; clc;
%%%% Descriptive data
load RT_CA_Cong_T1_LuisCiria_14-Sep-2017
RTc=RT;
load RT_CA_Incong_T1_LuisCiria_14-Sep-2017
RTdiff=RT-RTc;
data{1,1}=RTdiff'; %CA_T1

load RT_CB_Cong_T1_LuisCiria_14-Sep-2017
RTc=RT;
load RT_CB_Incong_T1_LuisCiria_14-Sep-2017
RTdiff=RT-RTc;
data{1,2}=RTdiff'; %CB_T1

load RT_CA_Cong_T2_LuisCiria_14-Sep-2017
RTc=RT;
load RT_CA_Incong_T2_LuisCiria_14-Sep-2017
RTdiff=RT-RTc;
data{2,1}=RTdiff'; %CA_T2

load RT_CB_Cong_T2_LuisCiria_14-Sep-2017
RTc=RT;
load RT_CB_Incong_T2_LuisCiria_14-Sep-2017
RTdiff=RT-RTc;
data{2,2}=RTdiff'; %CB_T2
%% std_stat function (for Mixed between and within-subjects designs). FDR correction for multiple comparisons. 
[pcond, pgroup, pinter, statscond, statsgroup, statsinter] = std_stat(data, 'groupstats','on',...
    'condstats','on','method','perm','mcorrect','fdr','mode','eeglab','alpha',NaN,...
    'paired',{'on' 'on'},'naccu',10000);

display (pinter)
%% Plot data blocks
m=mean(data{1,1});
m(1,2)=mean(data{2,1});
m(2,1)=mean(data{1,2});
m(2,2)=mean(data{2,2});
plot(m');

%% Plot data groups
mm=mean(m,2);
bar(mm);
ylim([100 120]);
xlim([0 3]);




