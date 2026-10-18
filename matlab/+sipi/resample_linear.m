function [time, output] = resample_linear(signal, factor)
%RESAMPLE_LINEAR Interpolate on the original sample-index interval.
% This illustrates interpolation; it is not an anti-aliasing resampler.
validateattributes(signal, {'numeric'}, {'vector','finite','nonempty'});
validateattributes(factor, {'numeric'}, {'scalar','real','finite','positive'});
if numel(signal) < 2
    error('sipi:ShortSignal', 'At least two samples are required.');
end
original_time = (0:numel(signal)-1)';
time = (0:1/factor:numel(signal)-1)';
output = interp1(original_time, double(signal(:)), time, 'linear');
end
