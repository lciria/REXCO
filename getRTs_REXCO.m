clear EEGOUT indtrg t RTmat RT ev
subjects = 1:18;
conditions = {'Cong_T2'};
sessions = 1;
groups = {'CA'};
event='2'; %Congruentes '2' Incongruentes '3'
resp_correc='14';
resp_incorrec='15';

if ismac
    separator = '/';
else separator = '\';
end

index = std_index(STUDY,subjects,sessions,conditions,groups);
%
for i = 1:length(index)
    EEGOUT = pop_loadset ('filename', ALLEEG(index(i)).filename, 'filepath', ALLEEG(index(i)).filepath);
    
    %%%%%%%%%% ACC %%%%%%%%%%%%  
    index2 = [EEGOUT.event(strcmp(resp_incorrec,{EEGOUT.event.type}))];
    ACC(i,1)=1-(length(index2)/60);
   
    %%%%%%%%%% RT %%%%%%%%%%%%%%
    count=1;
    for p=1:length(EEGOUT.event);       
        t = strfind (event,EEGOUT.event(p).type);
        if ~isempty(t)
            indtrg(count,1)=p;
            count = count+1;
        end
    end
    
    count = 1;
    for j = 1:length(indtrg)
        trglat = EEGOUT.event(indtrg(j)).latency;
        trgtype = EEGOUT.event(indtrg(j)).type;
        rsptype = EEGOUT.event(indtrg(j)+2).type;
        rsplat = EEGOUT.event(indtrg(j)+2).latency;        
        if (rsplat-trglat)/EEGOUT.srate>0.1 && ~isempty(strfind(rsptype,resp_correc))
            RTmat(count,1:2) = [trglat rsplat];
                count = count+1;
        end
    end
    RTmat(:,3)=RTmat(:,2)-RTmat(:,1);
    RT(i,1) = mean(RTmat(:,3));
    ev(i,1)=length(RTmat);
    clear EEGOUT indtrg t RTmat
end
% Save file
groups=cell2mat(groups); conditions=cell2mat(conditions);
savename=(['RT_' groups '_' conditions '_LuisCiria_' date]);
save(savename,'RT', 'ACC', 'ev');
