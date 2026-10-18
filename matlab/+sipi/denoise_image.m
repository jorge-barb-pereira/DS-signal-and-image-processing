function [mean_image, median_image] = denoise_image(image, width)
%DENOISE_IMAGE Compare odd square mean/median filters with symmetric padding.
if nargin < 2, width = 3; end
validateattributes(image, {'numeric','logical'}, {'2d','real','finite','nonempty'});
validateattributes(width, {'numeric'}, {'scalar','integer','finite','positive'});
if mod(width,2) == 0
    error('sipi:EvenWindow', 'Filter width must be odd.');
end
image = double(image);
mean_image = imfilter(image, ones(width)/(width*width), 'symmetric', 'same');
median_image = medfilt2(image, [width,width], 'symmetric');
end
