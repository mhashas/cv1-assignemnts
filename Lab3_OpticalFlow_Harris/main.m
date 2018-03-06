clear all
close all

verbose = 1;


sigma = 0.5;
g_size = 10;
k = 0.04;
supression_size = 5;
threshold = 5000;
top_N = 300;

for image_name = ["person_toy/00000001.jpg" "pingpong/0000.jpeg"]
    image = imread(image_name{1});
    %image = image(250:350,500:600,:);
    [Ix, Iy, H, rows, columns] = harris_corner_detector(image, sigma, g_size, k, supression_size, threshold, top_N);
    if verbose == 1
        figure
        imshow(Ix); pause(0.5)
        figure; imshow(Iy); pause(0.5)
        figure; imshow(image); pause(0.5); hold on; plot(rows,columns,'ro', 'MarkerSize', 5); pause(0.5)

        for i = 1:3
            angle = 90 * i;
            rot_image = imrotate(image, angle,'nearest','loose');

            [Ix, Iy, H, rows, columns] = harris_corner_detector(rot_image, sigma, g_size, k, supression_size, threshold, top_N);
            figure; imshow(rot_image); pause(0.5); hold on; plot(rows,columns,'ro', 'MarkerSize', 5); pause(0.5)
        end
    end
end