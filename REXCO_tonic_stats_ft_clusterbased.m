close all;
clear all;
clc;
cd 'F:\Datos Experimentales\Luis Ciria\REXCO\TONIC\';
load specdata_log_on_REXCO_TONIC_ArtifactsRejected_LuisCiria_8_nov_17;

%exercise=1 cool down=2 rest1=3 rest2=4 task1=5 task2=6 warm_up=7
period=1;
savename= (['Stats_ExerciseCA_vs_Rest1_Analysis_REXCO_LuisCiria_' date]);
chanlocs = {chanlocs.labels};

% Define Data
%%%%%%%%%%% Session Main Effect %%%%%%%%%%%
SP_CA_orig = (specdata{1,period});
SP_CB_orig = (specdata{2,period});

%%%% prepare database for ft
 CA = spec2ft(SP_CA_orig, chanlocs, 3, allfreqs);
 CB = spec2ft(SP_CB_orig, chanlocs, 3, allfreqs);

% find neighbours
cfg = [];
cfg.method = 'template';
cfg.template = 'F:\Datos Experimentales\Luis Ciria\CODEX\EEG\easycap30_neighbours.mat';

cfg.elecfile = 'F:\Datos Experimentales\Luis Ciria\CODEX\EEG\easycap30_lay.mat';
neighbours = ft_prepare_neighbours(cfg);

% Define design & statistic configuration
Nsub = 18;   %%% 18 for session effect -----   36 for period effect
cfg = [];
cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number
%cfg.frequency = freqrange;
%cfg.avgoverfreq = 'yes';
cfg.channel = chanlocs; % chanlocs(elecs);
cfg.method = 'montecarlo';       % use the Monte Carlo Method to calculate the significance probability
cfg.statistic   = 'ft_statfun_depsamplesT'; %'ft_statfun_depsamplesT'; %'depsamplesT';
cfg.correctm = 'cluster';
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan = 2;
cfg.numrandomization = 5000;
cfg.tail = 0; % -1, 1 or 0 (default = 0); one-sided or two-sided test
cfg.clustertail = 0;
cfg.alpha = 0.025;
cfg.neighbours = neighbours;
%cfg.clusterthreshold = 'nonparametric_common';
%%%%%%%%%%run statisticl analysis
[stat] = ft_freqstatistics(cfg, CA{:}, CB{:});

cd stats
save(savename,'stat', 'SP1_CA_orig', 'SP2_CA_orig');
cd ..

% extract data
% positive clusters
if isempty(stat.posclusters)==0;
    pos_cluster_pvals = [stat.posclusters(:).prob];
    pos_signif_clust = find(pos_cluster_pvals < stat.cfg.alpha);
    pos = stat.posclusterslabelmat == 1; %Change to cluster label number
    [elec,freq] = find(pos == 1);
    pos_elec = unique(elec);
    pos_elec_lab=chanlocs(pos_elec);
    pos_freq = unique(freq);
else
end

% negative clusters
if isempty(stat.negclusters)==0;
    neg_cluster_pvals = [stat.negclusters(:).prob];
    neg_signif_clust = find(neg_cluster_pvals < stat.cfg.alpha);
    neg = stat.negclusterslabelmat == 1;
    [elec,freq] = find(neg == 1);
    neg_elec = unique(elec);
    neg_elec_lab=chanlocs(neg_elec);
    neg_freq = unique(freq);
else
end

%% links of interest

% http://www.fieldtriptoolbox.org/tutorial/eventrelatedstatistics#permutation_test_based_on_cluster_statistics
% http://www.fieldtriptoolbox.org/tutorial/cluster_permutation_freq
% http://www.fieldtriptoolbox.org/tutorial/cluster_permutation_timelock#permutation_test
% http://www.fieldtriptoolbox.org/reference/ft_statistics_analytic (funciones "paramétricas" usadas anteriormente, cambiar por "FT_STATFUN_INDEPSAMPLEST")
% http://www.fieldtriptoolbox.org/reference/ft_statfun_depsamplest
% http://www.fieldtriptoolbox.org/reference/ft_statfun_indepsamplest
