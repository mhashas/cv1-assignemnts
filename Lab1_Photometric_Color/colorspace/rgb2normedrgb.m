function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
    output_image = input_image;
    for i = 1:3
       output_image(:,:,i) = output_image(:,:,i) ./ (input_image(:,:,1) + input_image(:,:,2) + input_image(:,:,3));
    end
end

