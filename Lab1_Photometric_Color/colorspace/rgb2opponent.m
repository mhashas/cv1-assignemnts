function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
    new_image = zeros(size(input_image));
    
    % O1 = (R-G)/sqrt(2)
    new_image(:,:,1) = (input_image(:,:,1)-input_image(:,:,2))./sqrt(2);
    
    % O2 = (R+G-2B)/sqrt(6)
    new_image(:,:,2) = (input_image(:,:,1)+input_image(:,:,2)-2*input_image(:,:,3))/sqrt(6);
    
    % O3 = (R+G+B)/sqrt(3)
    new_image(:,:,3) = (input_image(:,:,1)+input_image(:,:,2)+input_image(:,:,3))/sqrt(3);
    
    output_image = new_image;
end

