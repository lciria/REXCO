
%% Initialize STUDY

clear all

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab; % open eeglab

STUDY = []; CURRENTSTUDY = 0; ALLEEG=[]; EEG=[]; CURRENTSET=[];


%%

studyname = 'REXCO_CSD';

savename = 'REXCO_CSD.study';

taskname = 'Flanker';

datapath = 'F:\Datos Experimentales\Luis Ciria\REXCO'; % data path

groups = {'Subjects_FINAL_CSD'}; % cell variable with at least one element

subjects = [1:18]; % vector of subjects to analyse 

sessions = {'CA' 'CB'}; % cell variable with at least one element

conditions = {'rest1' 'warm_up' 'exercise' 'recover' 'rest2' 'task1' 'task2' ...
    'FixCross_T1' 'Cong_T1' 'Incong_T1' 'FixCross_T2'  'Cong_T2' 'Incong_T2'};


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
                
                [STUDY ALLEEG] = std_editset( STUDY, ALLEEG,...
                    'commands',{ 'index',ind, 'load', [cd separator dataset],...
                    'subject', ['s' int2str(subjects(subject))],...
                    'session', session,...
                    'group', groups{group},...
                    'condition',conditions{condition}});
                
                ind = ind+1;
                
            end
            cd ..            
        end
        cd ..
    end
    cd ..
end

%% Name and save the STUDY
[STUDY ALLEEG] = std_editset( STUDY, ALLEEG,  'name',...
studyname, 'task', taskname);

% update the GUI:
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = 1:length(EEG);
[STUDY, ALLEEG] = std_checkset(STUDY, ALLEEG);eeglab redraw

% Save the STUDY
[STUDY EEG] = pop_savestudy( STUDY, EEG,'filename', savename ,...
  'filepath', cd);