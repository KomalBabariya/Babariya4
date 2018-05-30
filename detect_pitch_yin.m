% Babariya, Komal
function [pitch, pitch_t] = detect_pitch_yin(x_t, t, fs, win_size, hop_size, min_lag, max_lag)

% compute blocks of xn of size win_size and hop as hopsize, convert t as a
% vector form duration
noverlap = win_size - hop_size;
xn = buffer(x_t, win_size, noverlap, 'nodelay');
t = datevec(t);
t_buf = buffer(t(:,6)', win_size, noverlap, 'nodelay');
[row, col] = size(xn);

%Define dl matrix where each row represent lag = index no. for each block
%in xn
dl = zeros(max_lag, col);

% define dl as a function of difference
for l = 1:max_lag
    del = (xn(1:row-l,:) - xn(l+1:row,:));
    dl(l,:) = sum(del.*del);
end

% Normalizing
norm_fac = cumsum(dl)./ repmat((1:max_lag)',1,col);
dl_norm = dl./norm_fac;

% Compute the lag index corresponding to minimum value in lag range
[min_val, min_ind] = min(dl_norm(min_lag:end,:));
min_ind = min_lag-1+min_ind;

% covert the index value into frequency(pitch).
pitch = fs./min_ind;
pitch_t = t_buf(1,:);
end