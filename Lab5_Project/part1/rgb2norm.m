function [output] = rgb2norm(input)
output = zeros(size(input));

R = input(:,:,1);
G = input(:,:,2);
B = input(:,:,3);

output(:,:,1) = R ./ (R + G + B);
output(:,:,2) = G ./ (R + G + B);
output(:,:,3) = B ./ (R + G + B);
output(isnan(output)) = 0;

end
