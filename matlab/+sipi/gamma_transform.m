function output = gamma_transform(image, gamma)
%GAMMA_TRANSFORM Apply a positive exponent to normalized grayscale values.
validateattributes(image, {'numeric','logical'}, {'2d','real','finite','nonempty','>=',0,'<=',1});
validateattributes(gamma, {'numeric'}, {'scalar','real','finite','positive'});
output = double(image).^gamma;
end
