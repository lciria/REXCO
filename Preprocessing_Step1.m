close all;
clear all;
clc;

eeglab;
ALLERP = buildERPstruct([]);
CURRENTERP = 0;

ICAWeightPath = 'F:\Datos Experimentales\Luis Ciria\REXCO\ICAWeight\';
WeightedSetPath = 'F:\Datos Experimentales\Luis Ciria\REXCO\WeightedSetPath\';
PreprocessedSetPath = 'F:\Datos Experimentales\Luis Ciria\REXCO\PreprocessedSetPath\';
cd 'F:\Datos Experimentales\Luis Ciria\LuisCiria-Project1-May-Sept-2016\DATA\PHYSIOLOGY'
% Load files
[file,path]=uigetfile('*.vhdr','Multiselect', 'on');
cd 'F:\Datos Experimentales\Luis Ciria\REXCO'

%%
for s = 1:length(file)
    
    %% get filename without extension
    point=find(file{1,s}=='.'); name=file{1,s}; name=name(1:point-7);
    band=find(file{1,s}=='_'); name2=file{1,s}; name2=name2(band(2)+1:band(2)+2);
    name=[name '_' name2]
    
    %%%%load EEG file excluding perfipheric channels %%%%
    EEG = pop_loadbv(path, file{1,s}, [], [1:31]);
    EEG = eeg_checkset( EEG );
    
    %% Remove extra channels
    EEG = pop_select( EEG,'nochannel',{'EOG_L' 'EOG_R'});
    
    %% Add Cz
    EEG=pop_chanedit(EEG, 'append',29,'changefield',{30 'labels' 'Cz'},...
        'changefield',{30 'theta' '90'},'changefield',{30 'radius' '0'},...
        'changefield',{30 'X' '3.75e-33'},'changefield',{30 'Y' '-6.12e-17'},...
        'changefield',{30 'Z' '1'},'changefield',{30 'sph_theta' '-90'},...
        'changefield',{30 'sph_phi' '90'},'changefield',{30 'sph_radius' '1'});
    
    %% Construct Cz and average re-reference
    EEG = pop_reref( EEG, [],'refloc',struct('labels',{'Cz'},'sph_radius',{1},...
        'sph_theta',{-90},'sph_phi',{90},'theta',{90},'radius',{0},'X',{3.75e-33},'Y',{-6.12e-17},...
        'Z',{1},'type',{''},'ref',{''},'urchan',{[]},'datachan',{0}));
    
    %%   Resample
    EEG = pop_resample( EEG, 500);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
    EEG = eeg_checkset( EEG );
    
    %% Kill Letter
    EEG = letterkilla (EEG);
    
    %% High-pass filter
   % EEG = pop_eegfiltnew(EEG, 1);
   % EEG = eeg_checkset( EEG );
    
    
EEG  = pop_basicfilter( EEG,  1:30 , 'Boundary', 'boundary', 'Cutoff', [0.1 40], ...
    'Design', 'butter', 'Filter', 'bandpass', 'Order',  2, 'RemoveDC', 'on' );    
EEG = eeg_checkset( EEG );
   
%% Save dataset
    EEG = pop_saveset( EEG, 'filename',[name '_Preprocessed.set'],'filepath',[PreprocessedSetPath]);
    
    %%  Cut signals for noisy subjects
            fin = [EEG.event(strcmp('11',{EEG.event.type})).latency];
            EEG = pop_rmdat(EEG, {'8'},[0 fin(end)/EEG.srate] ,0);
            EEG = eeg_checkset( EEG );
    
    %% Cut part of signals for noisy subjects (for subject 801_CB)
    %             ini = [EEG.event(strcmp('5',{EEG.event.type})).latency]-1;
    %             EEG = eeg_eegrej(EEG, [ini(1) ini(2)]);
    %             EEG = eeg_checkset( EEG );
    
    %% Cut part of signals for noisy subjects (for subject 801_CB)
    %             ini = [EEG.event(strcmp('9',{EEG.event.type})).latency]-1;
    %             EEG = eeg_eegrej(EEG, [ini(end) length(EEG.data)]);
    %             EEG = eeg_checkset( EEG );
    
    %% Cut part of signals for noisy subjects (for subject 801_CB)
    %     fin = [EEG.event(strcmp('14',{EEG.event.type})).latency];
    %     EEG = pop_rmdat(EEG, {'8'},[0 fin(end)/EEG.srate] ,0);
    %     EEG = eeg_checkset( EEG );
    
    %% ************************RUN ICA**********************
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    
    %% *******************Export ICA Weight and save Weighted set**********************
    pop_expica(EEG, 'weights', [ICAWeightPath name]);
    
    EEG = pop_saveset( EEG, 'filename',[name 'Weighted_2.set'],'filepath',[WeightedSetPath]);
    
end;

clear EEG;