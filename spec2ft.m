function ftdata = spec2ft(specdata, chanlocs, subdim, allfreqs) 

%%%%
for i = 1:size(specdata,subdim)
    ftdata{i}.powspctrm = specdata(:,:,i)';
    ftdata{i}.freq = allfreqs;
    ftdata{i}.dimord = 'chan_freq';
    ftdata{i}.label = chanlocs;
end