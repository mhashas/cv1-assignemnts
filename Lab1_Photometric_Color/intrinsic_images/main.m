clear
clc
close all

ball = imread('ball.png');
ball_reflectance = imread('ball_reflectance.png');
ball_shading = imread('ball_shading.png');


% Reconstruct ball
ball_reconstructed = iid_image_formation(ball_reflectance, ball_shading);

print_plots(ball, ball_reconstructed, ball_reflectance, ball_shading);

% Recolor ball
green_ball = recoloring(ball_reflectance, ball_shading, 0, 1, 0);
magenta_ball = recoloring(ball_reflectance, ball_shading, 1, 0 ,1);

print_plots(ball, green_ball, magenta_ball, zeros(size(ball)));

function print_plots(image_1, image_2, image_3, image_4)
figure;
subplot(2,2,1);
imshow(image_1);

subplot(2,2,2);
imshow(image_2);

subplot(2,2,3);
imshow(image_3);


subplot(2,2,4);
imshow(image_4);
end

