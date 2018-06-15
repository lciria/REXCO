close all;
clear all;
clc;

cd 'F:\Datos Experimentales\Luis Ciria\REXCO\WeightedSetPath\'
% Load files
[file,path]=uigetfile('*.set','Multiselect', 'on');
ICA_Prunned_path='F:\Datos Experimentales\Luis Ciria\REXCO\ICA_Prunned\';

for s = 1:length(file)
    eeglab;
    ALLERP = buildERPstruct([]);
    CURRENTERP = 0;
    %%%%load EEG file %%%%
    EEG = pop_loadset(file{1,s}, path);
    EEG = eeg_checkset( EEG );
    
    %%% get filename without extension
    point=find(file{1,s}=='.'); name=file{1,s}; name=name(1:point-10);
    
    %**********Plot ICA Components***********%
    pop_topoplot(EEG,0, [1:15] ,'ICA',[5 6] ,0,'electrodes','off');
    title (name);
    
    pop_eegplot( EEG, 0, 1, 1);

    pause;
    
    com=input('Component to reject = ');
    
    if com==0
        
    else
        pop_eegplot( EEG, 1, 10, 0);
        
        EEG = pop_subcomp( EEG, [com(1,1)], 0);
        EEG.setname=([name '_ICA_pruned']);
        EEG = eeg_checkset( EEG );
        pop_eegplot( EEG, 1, 10, 0);
        
        sav=input('Save = ');
        
        if sav==s
            EEG = pop_saveset( EEG, 'filename',[name '_ICA_prunned.set'],'filepath',[ICA_Prunned_path]);
        else sav==0
        end
    end
    clearvars -except file path s ICA_Prunned_path
    close all
end

