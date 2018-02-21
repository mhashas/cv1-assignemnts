clear
clc
close all

original_image = imread('awb.jpg');
counter_example = imread('awb_counter_example.jpg');

original_image_corrected = gray_world_transformation(original_image);
counter_example_corrected = gray_world_transformation(counter_example);

print_plots(original_image, original_image_corrected);
print_plots(counter_example, counter_example_corrected);

function corrected_image = gray_world_transformation(image)
corrected_image = im2double(image)
for i=1:3 %loop over R,G,B channels
    mean_channel = mean(mean(image(:, :,i)));
    corrected_image(:,:,i) = 128 ./ mean_channel * corrected_image(:,:,i)
end
end

function print_plots(original, corrected)
figure;
subplot(1,2,1);
imshow(original);

subplot(1,2,2);
imshow(corrected);
end