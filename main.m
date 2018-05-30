% Babariya, Komal

clc;
clear all;

% Parameters
audio_files=dir('pitch\*.wav');
win_size = 2048;
hop_size = 256;
min_lag = 15;
max_lag = 800;

% For all audio files in the directory plot pitch detction

for i = 1: numel(audio_files)
    figure(i);
    plot_pitch(strcat('pitch\',audio_files(i).name), win_size, hop_size, min_lag, max_lag);
    suptitle(audio_files(i).name);
end
