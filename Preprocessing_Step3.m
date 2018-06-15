
%% Reject Artifactss based on spectral power
clear all
eeglab; % open eeglab

datapath = 'F:\Datos Experimentales\Luis Ciria\REXCO'; % data path
groups = {'Subjects_FINAL'}; % cell variable with at least one element
subjects = [1:18]; % vector of subjects to analyse
sessions = {'CA' 'CB'}; % cell variable with at least one element
conditions = {'rest1','warm_up', 'exercise', 'recover','task1','rest2','task2'};
%conditions = {'Cong_T1', 'Incong_T1','Cong_T2', 'Incong_T2'};

if ismac == 1
    separator = '/';
else
    separator = '\';
end

ind = 1;
%%
for group = 1:length(groups);
    cd ([datapath separator groups{group}])
    for subject = 1:length(subjects);
        cd (['s' int2str(subjects(subject))]);
        for session = 1:length(sessions);
            cd (sessions{session})
            for condition = 1:length(conditions)
                dataset = dir(['*' conditions{condition} '.set']);
                dataset = dataset.name;
                
                EEG = [];
                EEG = pop_loadset('filename', dataset, 'filepath', cd);
                
                %%%TONIC
                [EEG selectedregions]= pop_rejcont(EEG, 'elecrange',[1:30] ,'epochlength',1,'freqlimit',[20 40] ,...
                    'threshold',25,'contiguous',4,'addlength',0.25,'taper','hamming','eegplot','off','verbose','on','onlyreturnselection','off');
                
                if isempty(selectedregions)
                     trialsrejected(ind,1)=0;
                else
                trialsrejected(ind,1)=sum(selectedregions(:,2)-selectedregions(:,1))/500;
                end
                %%%PHASIC
%                 trials=size(EEG.data,3);
%                 % Reject EMG artifacts
%                 EEG = pop_rejspec( EEG, 1,'elecrange',[1:30] ,'method','fft','threshold',[-100 25] ,...
%                     'freqlimits',[20 40] ,'eegplotcom','','eegplotplotallrej',0,'eegplotreject',1);
%                 % Reject eye movements artifacts
%                 EEG = pop_rejspec( EEG, 1,'elecrange',[1:30] ,'method','fft','threshold',[-50 50] ,...
%                     'freqlimits',[0 2] ,'eegplotcom','','eegplotplotallrej',0,'eegplotreject',1);
%                 
%                 % Save amount of artifacts rejected
%                 trialsrejected(ind,1)=60-size(EEG.data,3);
                
                % Save dataset without artifacts rejected
                EEG = pop_saveset( EEG,'filename', dataset,'filepath',cd);
                ind = ind+1;
            end
            cd ..
        end
        cd ..
    end
    cd ..
end
