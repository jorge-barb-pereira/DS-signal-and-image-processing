function y = linear_interpolate(x, lower, upper, value_lower, value_upper)
%LINEAR_INTERPOLATE Interpolate inside a strictly increasing finite interval.
validateattributes(x, {'numeric'}, {'real','finite','nonempty'});
validateattributes(lower, {'numeric'}, {'scalar','real','finite'});
validateattributes(upper, {'numeric'}, {'scalar','real','finite'});
validateattributes(value_lower, {'numeric'}, {'scalar','finite'});
validateattributes(value_upper, {'numeric'}, {'scalar','finite'});
if upper <= lower
    error('sipi:InvalidInterval', 'The upper endpoint must exceed the lower endpoint.');
end
if any(x(:) < lower | x(:) > upper)
    error('sipi:OutsideInterval', 'Queries must lie within the interpolation interval.');
end
y = value_lower + (double(x)-lower) .* (value_upper-value_lower) ./ (upper-lower);
end
