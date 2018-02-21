clear
clc
close all

original_image = imread('awb.jpg');
corrected_image = im2double(original_image);

for i=1:3 %loop over R,G,B channels
    mean_channel = mean(mean(original_image(:, :,i)));
    corrected_image(:,:,i) = 128 ./ mean_channel * corrected_image(:,:,i)
end

figure, imshow(original_image);
figure, imshow(corrected_image);