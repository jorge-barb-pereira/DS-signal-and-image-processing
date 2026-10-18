function [frequency, amplitude] = amplitude_spectrum(signal, sample_rate)
%AMPLITUDE_SPECTRUM One-sided rectangular-window spectrum of a real signal.
% DC and the even-length Nyquist bin are not doubled. No mean is removed.
validateattributes(signal, {'numeric'}, {'vector','real','finite','nonempty'});
validateattributes(sample_rate, {'numeric'}, {'scalar','real','finite','positive'});
signal = double(signal(:));
n = numel(signal);
transform = fft(signal);
amplitude = abs(transform(1:floor(n/2)+1)) / n;
if mod(n,2) == 0
    amplitude(2:end-1) = 2*amplitude(2:end-1);
else
    amplitude(2:end) = 2*amplitude(2:end);
end
frequency = (0:floor(n/2))' * sample_rate / n;
end
