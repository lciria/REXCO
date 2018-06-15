% ersp data: frequencies X time X chan X subject
clear all
%load ERSPdata_log_on_REXCO_PhasicDesign_BaseLine_300ms_ArtifactsRejected_LuisCiria_8_Nov_17
alltimes = alltimes./1000;
chanlocs = {STUDY.changrp.name};
%%
%%%%% statistics
%%%% TASK 1:  Congruent=1  Incongruent=5   FixCross=3
%%%% TASK 2:  Congruent=2  Incongruent=6   FixCross=4
stimulus=2;   
freqrange = [20 40];
latency = [0 0.5];
lat_ini=find(alltimes>latency(1)); lat_fin=find(alltimes>latency(2));
alltimes2=alltimes(1,lat_ini:lat_fin);
savename = 'stats_CongruencyEffect_task2_20_40Hz_REXCO_CSD_LuisCiria';

% main effect
CA_orig = (erspdata{1,stimulus});    
CB_orig = (erspdata{2,stimulus});

% find neighbours
cfg = [];
cfg.method = 'template';
cfg.template = 'F:\Datos Experimentales\Luis Ciria\CODEX\EEG\easycap30_neighbours.mat';
cfg.elecfile = 'F:\Datos Experimentales\Luis Ciria\CODEX\EEG\easycap30_lay.mat';
neighbours = ft_prepare_neighbours(cfg);

% prepare database for ft
CA_shiftdim = shiftdim(CA_orig,2);
CB_shiftdim = shiftdim(CB_orig,2);

CA = ersp2ft(CA_shiftdim, chanlocs, 2, allfreqs, alltimes, 'chan_freq_time');
CB = ersp2ft(CB_shiftdim, chanlocs, 2, allfreqs, alltimes, 'chan_freq_time');

% statistics configuration
cfg = [];
cfg.latency = latency;
%cfg.avgovertime = 'yes';
cfg.frequency = freqrange;
cfg.avgoverfreq = 'yes';
cfg.channel = chanlocs;
cfg.method = 'montecarlo'; % use the Monte Carlo Method to calculate the significance probability
cfg.statistic   = 'ft_statfun_depsamplesT';
cfg.correctm = 'cluster';
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan = 2;
cfg.numrandomization = 5000; %4000
%cfg.ivar  = 1;
cfg.neighbours = neighbours;
cfg.alpha       = 0.05;
cfg.tail        = 0; % two-sided test
cfg.correcttail = 'alpha';

% Define design & statistic configuration
Nsub = 36;
cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

% run statisticl analysis
[stat] = ft_freqstatistics(cfg, CA{:}, CB{:});

 cd stats
 save (savename,'stat','CA', 'CB')
 cd ..

 % extract data
% positive clusters
if isempty(stat.posclusters)==0;
    pos_cluster_pvals = [stat.posclusters(:).prob];
    pos_signif_clust = find(pos_cluster_pvals < stat.cfg.alpha);
    pos = stat.posclusterslabelmat == 1; %Change to cluster label number
    [elec,time] = find(pos == 1);
    pos_elec = unique(elec); pos_elec=chanlocs(pos_elec); 
    pos_time = alltimes2(unique(time));
else
end

% negative clusters
if isempty(stat.negclusters)==0;
    neg_cluster_pvals = [stat.negclusters(:).prob];
    neg_signif_clust = find(neg_cluster_pvals < stat.cfg.alpha);
    neg = stat.negclusterslabelmat == 1;
    [elec,time] = find(squeeze(neg) == 1);
    neg_elec = unique(elec); neg_elec=chanlocs(neg_elec); 
    neg_time = alltimes2(unique(time));
else
end



