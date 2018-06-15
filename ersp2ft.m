function ftdata = ersp2ft(erspdata, chanlocs, subdim, freqs, times, dimord)
% dimord = chan, freq, time

%%%%
for i = 1:size(erspdata,subdim)
    ftdata{i}.powspctrm = squeeze(erspdata(:,i,:,:));
    ftdata{i}.freq = freqs;
    ftdata{i}.dimord = dimord;
    ftdata{i}.label = chanlocs;
    ftdata{i}.time = times;
end