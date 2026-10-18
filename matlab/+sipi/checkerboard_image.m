function image = checkerboard_image(n, minimum, maximum, angle_degrees)
%CHECKERBOARD_IMAGE Eight-by-eight board with a directional illumination ramp.
if nargin < 4, angle_degrees = 0; end
validateattributes(n, {'numeric'}, {'scalar','integer','finite','>=',8});
validateattributes(minimum, {'numeric'}, {'scalar','real','finite','>=',0,'<=',1});
validateattributes(maximum, {'numeric'}, {'scalar','real','finite','>=',minimum,'<=',1});
validateattributes(angle_degrees, {'numeric'}, {'scalar','real','finite'});
if mod(n,8) ~= 0
    error('sipi:InvalidSize', 'Image size must be divisible by eight.');
end
[columns, rows] = meshgrid(0:n-1, 0:n-1);
board = mod(floor(columns/(n/8)) + floor(rows/(n/8)), 2);
ramp = columns*cosd(angle_degrees) + rows*sind(angle_degrees);
ramp = (ramp-min(ramp(:))) / (max(ramp(:))-min(ramp(:)));
image = board .* (minimum + (maximum-minimum).*ramp);
end
