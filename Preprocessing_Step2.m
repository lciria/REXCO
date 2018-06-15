
close all;
clear all;
clc;

eeglab;

files = dir('*prunned.set');
files = {files.name}';

conditions = {'rest1','warm_up', 'exercise', 'recover','task1','rest2','task2'};
conditionstype = {'4','5', '6', '7','8','9','10'};

epochs = {'FixCross','Cong', 'Incong'};
epochtype = {'1', '2', '3'};
%%
for i = 1:length(files) % loop subjects
    file = files{i};
    point = find(file=='.');
    name = file(1:point-1);
    
    EEG = [];
    EEG = pop_loadset('filename', file, 'filepath', cd);
    
    %%
    rest1ini = [EEG.event(strcmp('4',{EEG.event.type})).latency];
    rest1fin = [EEG.event(strcmp('4',{EEG.event.type})).latency]+900*EEG.srate;
    
    warmini = [EEG.event(strcmp('5',{EEG.event.type})).latency];
    warmfin = [EEG.event(strcmp('5',{EEG.event.type})).latency]+600*EEG.srate;
    
    exerciseini = [EEG.event(strcmp('6',{EEG.event.type})).latency];
    exercisefin = [EEG.event(strcmp('6',{EEG.event.type})).latency]+1800*EEG.srate;
    
    recoverini = [EEG.event(strcmp('7',{EEG.event.type})).latency];
    recoverfin = [EEG.event(strcmp('7',{EEG.event.type})).latency]+600*EEG.srate;
    
    task1ini = [EEG.event(strcmp('8',{EEG.event.type})).latency];
    t1f = [EEG.event(strcmp('9',{EEG.event.type})).urevent]-1; %last task event
    task1fin = [EEG.event(t1f(1)).latency];
    
    rest2ini = [EEG.event(strcmp('9',{EEG.event.type})).latency];
    rest2fin = [EEG.event(strcmp('9',{EEG.event.type})).latency]+900*EEG.srate;
    
    task2ini = [EEG.event(strcmp('10',{EEG.event.type})).latency];
    t2f = length(EEG.event);
    task2fin = [EEG.event(t2f).latency];
        
    times = [(rest1fin-rest1ini)/EEG.srate...
        (warmfin-warmini)/EEG.srate ...
        (exercisefin-exerciseini)/EEG.srate ...
        (recoverfin-recoverini)/EEG.srate...
        (task1fin-task1ini)/EEG.srate...
        (rest2fin-rest2ini)/EEG.srate...
        (task2fin-task2ini)/EEG.srate];
    
    %%
    for cond = 1:length(conditions)
        EEG_cond = [];
        
        EEG_cond = pop_rmdat(EEG, {conditionstype(cond)},...
            [0 times(cond)] ,0);
        
        EEG_cond = pop_saveset( EEG_cond,...
            'filename', [name '_' conditions{cond} '.set']...
            ,'filepath',cd);
    end
    %%   
    for epoch = 1:length(epochs)
        EEG_epoch = [];
        %%% Task1
        EEG_epoch = pop_rmdat(EEG, {'8'},[0 times(5)] ,0);        
        EEG_epoch = pop_epoch( EEG_epoch, {epochtype{epoch}}, [-1  2]);        
        EEG_epoch = pop_saveset( EEG_epoch,...
            'filename', [name '_' epochs{epoch} '_T1.set']...
            ,'filepath',cd);
        
        EEG_epoch = [];
        %%% Task2
        EEG_epoch = pop_rmdat(EEG, {'10'},[0 times(7)] ,0);
        EEG_epoch = pop_epoch( EEG_epoch, {epochtype{epoch}}, [-1  2]);
        EEG_epoch = pop_saveset( EEG_epoch,...
            'filename', [name '_' epochs{epoch} '_T2.set']...
            ,'filepath',cd);       
    end
end