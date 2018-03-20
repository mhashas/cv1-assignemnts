function [output] = rgb2opponent(input)
output = zeros(size(input));

R = input(:,:,1);
G = input(:,:,2);
B = input(:,:,3);

output(:,:,1) = (R - G) / sqrt(2);
output(:,:,2) = (R + G - (2 * B)) / sqrt(6);
output(:,:,3) = (R + G + B) / sqrt(3);

end