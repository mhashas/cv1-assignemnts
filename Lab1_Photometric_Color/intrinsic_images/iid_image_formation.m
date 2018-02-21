clear
clc
close all

ball = imread('ball.png');
ball_reflectance = imread('ball_reflectance.png');
ball_shading = imread('ball_shading.png');

ball_reconstructed = iid_transformation(ball_reflectance, ball_shading);

print_plots(ball, ball_reconstructed, ball_reflectance, ball_shading);

function reconstructed_image = iid_transformation(reflectance, shading)
reconstructed_image = im2double(reflectance) .* im2double(shading); % I = R x S
end

function print_plots(ball, ball_reconstructed, ball_reflectance, ball_shading)
figure;
subplot(2,2,1);
imshow(ball);

subplot(2,2,2);
imshow(ball_reconstructed);

subplot(2,2,3);
imshow(ball_reflectance);

subplot(2,2,4);
imshow(ball_shading);
end