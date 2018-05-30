% Babariya, Komal
function [] = plot_pitch(filepath, win_size, hop_size, min_lag, max_lag)
%import audio
[x_t, fs, t] = import_audio(filepath);

% Compute pitch using ACF
[acfpitch, acfpitch_t] = detect_pitch_acf(x_t, t, fs, win_size, hop_size, min_lag, max_lag);

% Compute pitch using YIN
[yinpitch, yinpitch_t] = detect_pitch_yin(x_t, t, fs, win_size, hop_size, min_lag, max_lag);

% Subpots
subplot(2,1,1);
plot(acfpitch_t,acfpitch,'.k');
title('ACF');
xlabel('Time');
ylabel('Pitch');
subplot(2,1,2);
plot(yinpitch_t,yinpitch,'.k');
title('YIN');
xlabel('Time');
ylabel('Pitch');

end
