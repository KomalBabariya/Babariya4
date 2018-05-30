% Babariya, Komal
function [pitch, pitch_t] = detect_pitch_acf(x_t, t, fs, win_size, hop_size, min_lag, max_lag)

% Computing ACF using convolution property

% noverlap = win_size - hop_size;
% lag = max_lag;
% pad_no = 2^nextpow2(win_size + lag - 1);
% x_padd = [zeros(1,pad_no/2) x_t zeros(1,pad_no/2)];
% [s,f,t_sf] = spectrogram(x_padd,win_size,noverlap,win_size,fs);
% col = size(s,2);
% pitch_func = real(ifft(abs(s).*abs(s)));
% n = min_lag :1:max_lag;
% norm_fac = 1./(win_size - n);
% acf = diag(norm_fac)*pitch_func(min_lag + 1: max_lag + 1, :); % as lag starts from zero
% [max_val, max_ind] = max(acf);
% max_ind = min_lag + max_ind;
% pitch = f(max_ind);
% pitch_t = t_sf;

% -------------------------------------------------------------------------------

% Computing ACF using defination

% compute blocks of xn of size win_size and hop as hopsize, convert t as a
% vector form duration
noverlap = win_size - hop_size;
xn = buffer(x_t, win_size, noverlap, 'nodelay');
t = datevec(t);
t_buf = buffer(t(:,6)', win_size, noverlap, 'nodelay');
[row, col] = size(xn);

%Define rl matrix where each row represent lag = index no. for each block
%in xn
rl = zeros(max_lag, col);

% define rl as a function of matching
for l = 1:max_lag
    rl(l,:) = sum(xn(1:row-l,:).*xn(l+1:row,:));
end

% Normalizing
dl_norm = rl./(win_size - repmat((1:max_lag)',1,col));

% Compute the lag index corresponding to maximum value in lag range
[max_val, max_ind] = max(dl_norm(min_lag:end,:));
max_ind = min_lag-1+max_ind;

% covert the index value into frequency(pitch).
pitch = fs./max_ind;
pitch_t = t_buf(1,:);
end