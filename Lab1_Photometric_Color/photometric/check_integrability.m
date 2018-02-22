function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
p = zeros(size(normals));
q = zeros(size(normals));
SE = zeros(size(normals));

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy


% ========================================================================

% ∂f/∂x = a(x, y)/c(x, y)
p = normals(:,:,1)./normals(:,:,3);
% ∂f/∂y = b(x, y)/c(x, y)
q = normals(:,:,2)./normals(:,:,3);

p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE


% ========================================================================

% Approximate second derivative by neighbour difference

[h, w, ~] = size(normals);
dp_dy = zeros(size(p));
dq_dx = zeros(size(q));

for j = 1:w-1
    dp_dy(:, j) = (q(:, j+1) - q(:, j));
end

for i = 1:h-1
    dq_dx(i, :) = (q(i+1, :) - q(i, :));
end

SE = (dp_dy - dq_dx).^2;

end

