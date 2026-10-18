function [mask, level] = segment_image(image)
%SEGMENT_IMAGE Otsu thresholding after explicit grayscale normalization.
normalized = sipi.contrast_stretch(image);
level = graythresh(normalized);
mask = normalized > level;
end
