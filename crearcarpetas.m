% create a subject/sessions folder structure and move files

% first create the directory where you want you structure to be created and
% feed into the parentdir variable.
parentdir = 'F:\Datos Experimentales\DariasThomas\tDCS\EEG\Procesados\Subjects_FINAL';


% do not change the following variable if you are using a mac or 
% change to mac = 0 if you are using a PC
mac = 0; 

if mac == 1
    separator = '/';
elseif mac == 0
    separator = '\';
end

% create your subjects variable with only the first characters of your
% filenames that are distinct only between subjects but NOT sessions or
% conditions
subjects = {'01TDCS' '02TDCS' '03TDCS' '05TDCS' '06TDCS' '07TDCS' '08TDCS'...
    '09TDCS' '10TDCS' '11TDCS' '12TDCS' '13TDCS' '14TDCS'...
    '15TDCS' '16TDCS' '17TDCS' '18TDCS' '19TDCS' '21TDCS' '22TDCS' '23TDCS' '24TDCS'...
    '26TDCS' '27TDCS' '28TDCS' '29TDCS' '30TDCS' '32TDCS'...
    '33TDCS' '34TDCS' '35TDCS' '36TDCS'};

% create your conditions variable (separate folders)
sessions = {'ANO' 'CAT' 'SHAM'};


for i = 1:length(subjects);
    
    subjectdir = [parentdir separator 's' int2str(i)];    
    mkdir (subjectdir)
    
    for j = 1:length(sessions)        
        conditiondir = [subjectdir separator sessions{j}];
        
        mkdir (conditiondir);
        
        dataset = dir([subjects{i} '_' sessions{j} '*.*']);
        sets = {dataset.name}';
        
        cellfun (@(x) copyfile(x,conditiondir), sets)        
    end
end