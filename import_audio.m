% Babariya, Komal
function [x_t, fs, t] = import_audio(filepath)
% Read audio file
[y, fs] = audioread(filepath);
% If stereo convert it to mono file
x_t = y(:,1)';
endtime = (length(x_t)- 1)/fs;
ts = 1/fs;
t = seconds(0:ts:endtime);
end