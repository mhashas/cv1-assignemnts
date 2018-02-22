function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

[N, M, D] = size(input_image);
output_image = zeros(N, M, D+1);

% ligtness method
for i = 1:N
    for j = 1:M
        output_image(i,j,2) = max(input_image(i,j,:))-min(input_image(i,j,:))/2;
    end
end
% average method
output_image(:,:,3) = (input_image(:,:,1)+input_image(:,:,2)+input_image(:,:,3))./3;
% luminosity method
output_image(:,:,4) = (input_image(:,:,1).*0.21+input_image(:,:,2).*0.72+input_image(:,:,3).*0.07);
% built-in MATLAB function 
output_image(:,:,1) = rgb2gray(input_image);

end

