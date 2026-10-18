function value = relative_error(reference, candidate)
%RELATIVE_ERROR L2 relative error with zero-padding and explicit zero handling.
validateattributes(reference, {'numeric'}, {'vector','nonempty','finite'});
validateattributes(candidate, {'numeric'}, {'vector','nonempty','finite'});
x = double(reference(:));
y = double(candidate(:));
n = max(numel(x), numel(y));
x(end+1:n) = 0;
y(end+1:n) = 0;
denominator = norm(x, 2);
if denominator == 0
    if norm(y, 2) == 0
        value = 0;
        return;
    end
    error('sipi:ZeroReference', 'Relative error is undefined for a zero-energy reference.');
end
value = norm(y-x, 2) / denominator;
end
