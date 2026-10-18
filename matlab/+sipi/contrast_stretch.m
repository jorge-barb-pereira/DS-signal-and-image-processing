function output = contrast_stretch(image)
%CONTRAST_STRETCH Map a finite grayscale image to [0,1]; constants become zero.
validateattributes(image, {'numeric','logical'}, {'2d','real','finite','nonempty'});
image = double(image);
lower = min(image(:));
upper = max(image(:));
if upper == lower
    output = zeros(size(image));
else
    output = (image-lower) / (upper-lower);
end
end
