dataset = dir('*.set');

for i = 1:size(dataset,1);
    
    set = dataset(i).name;
    EEG = [];
    EEG = pop_loadset('filename',set);
    
    figure;
    [spectra,freqs,speccomp,contrib,specstd] =...
        spectopo(EEG.data, 0, EEG.srate,...
        'freq', [6 10 25],...
        'freqrange', [3 40],...
        'winsize',round(EEG.srate*1),...
        'overlap',round(EEG.srate*0),...
        'wintype','hamming',...
        'plot','on',...
        'plotmean','off',...
        'chanlocs', EEG.chanlocs,...
        'electrodes','off');
    
    eegplot(EEG.data);
    options.WindowStyle='normal';
    prompt = 'select channels to interpolate: ';
    
    interp = inputdlg (prompt,'Interpolate channels',...
        1,{''},options); % cancel if no channel
            
    cd ([cd '/Interpolated'])

    while ~isempty (interp)
        EEG = pop_interp(EEG, str2double(interp{1,1}), 'spherical');
        
        
        EEG = pop_saveset( EEG,'filename',set);
        
        EEG = pop_loadset('filename',set);

        figure;
        [spectra,freqs,speccomp,contrib,specstd] =...
            spectopo(EEG.data, 0, EEG.srate,...
            'freq', [6 10 25],...
            'freqrange', [3 40],...
            'winsize',round(EEG.srate*1),...
            'overlap',round(EEG.srate*0),...
            'wintype','hamming',...
            'plot','on',...
            'plotmean','off',...
            'chanlocs', EEG.chanlocs,...
            'electrodes','off');
        
        eegplot(EEG.data);
        
        options.WindowStyle='normal';
        prompt = 'select channels to interpolate: ';
        
        interp = inputdlg (prompt,'Interpolate channels',...
            1,{''},options); % cancel if no channel
    end
    
    cd ..
    
    close all
end