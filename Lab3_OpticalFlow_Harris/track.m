clear all
close all

example = 'person_toy'; %change to pingpong for other example

if strcmp(example, 'person_toy')
    image1 = imread('person_toy/00000001.jpg');
    padding = 8;
    extension = '.jpg';
    save_folder = 'person_toy_flow/';
    read_folder = 'person_toy/';
    start_loop = 2;
    end_loop = 104;
else
    image1 = imread('pingpong/0000.jpeg');
    padding = 4;
    extension = '.jpeg';
    save_folder = 'pingpong_flow/';
    read_folder = 'pingpong/';
    start_loop = 1;
    end_loop = 52;
end

g1_sigma = 0.8;
g1_size = 9;
g2_sigma = 0.3;
g2_size = 9;

k = 0.04;
supression_size = 15;
top_N = 100;
method = 'Harris';

flow_scaling = 1.2;

[Ix, Iy, H, rows, columns] = harris_corner_detector(image1, g1_sigma, g1_size, g2_sigma, g2_size, k, supression_size, top_N, method);

figure
imshow(image1)
hold on
plot(rows,columns,'ro', 'MarkerSize', 5)

[N, M, ~] = size(image1);
for i = start_loop:end_loop
    image2 = imread(strcat(read_folder, pad(num2str(i), padding, 'left','0'), extension));    
    [Vx, Vy] = lucas_kanade(image1,image2, floor(rows), floor(columns), supression_size);
    imshow(image2)
    hold on
    quiver(floor(rows),floor(columns),Vx,Vy)
    rows = rows + flow_scaling*Vx;
    columns = columns + flow_scaling*Vy;
    plot(rows,columns,'ro', 'MarkerSize', 5)
    saveas(gcf,strcat(save_folder, pad(num2str(i), padding, 'left','0'), extension))
    pause(0.01)
    image1 = image2;
    
end
