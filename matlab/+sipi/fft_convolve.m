function output = fft_convolve(x, y)
%FFT_CONVOLVE Linear convolution through correctly zero-padded FFTs.
validateattributes(x, {'numeric'}, {'vector','finite','nonempty'});
validateattributes(y, {'numeric'}, {'vector','finite','nonempty'});
n = numel(x)+numel(y)-1;
output = ifft(fft(double(x(:)),n).*fft(double(y(:)),n));
if isreal(x) && isreal(y), output = real(output); end
end
