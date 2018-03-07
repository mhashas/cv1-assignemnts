clear all
close all

verbose = 1;

g1_sigma = 0.8;
g1_size = 9;
g2_sigma = 0.3;
g2_size = 9;

k = 0.04;
supression_size = 5;
top_N = 250;
method = 'Shi-Tomasi'; %['Harris' | 'Eigen' | 'Shi-Tomasi']

for image_name = ["person_toy/00000001.jpg" "pingpong/0000.jpeg"]
    image = imread(image_name{1});
    splitted = strsplit(image_name{1},'/');
    set_name = splitted{1};
    
    %image = image(250:350,500:600,:);
    [Ix, Iy, H, rows, columns] = harris_corner_detector(image, g1_sigma, g1_size, g2_sigma, g2_size, k, supression_size, top_N, method);
    if verbose == 1
        figure
        imshow(Ix); pause(0.5)
        saveas(gcf,strcat('harris_gradient_rotation/', 'Ix_', set_name , '.jpg'));
        
        figure; imshow(Iy); pause(0.5)
        saveas(gcf,strcat('harris_gradient_rotation/', 'Iy_', set_name , '.jpg'));
        
        figure; imshow(image); pause(0.5); hold on; plot(rows,columns,'ro', 'MarkerSize', 5); pause(0.5)
        saveas(gcf,strcat('harris_gradient_rotation/', 'corners_', method, '_',num2str(0),'_', set_name , '.jpg'));
        
        for i = 1:3
            angle = 90 * i;
            rot_image = imrotate(image, angle,'nearest','loose');
            
            [Ix, Iy, H, rows, columns] = harris_corner_detector(rot_image, g1_sigma, g1_size, g2_sigma, g2_size, k, supression_size, top_N, method);
            figure; imshow(rot_image); pause(0.5); hold on; plot(rows,columns,'ro', 'MarkerSize', 5); pause(0.5)
            saveas(gcf,strcat('harris_gradient_rotation/', 'corners_', method, '_',num2str(angle),'_', set_name , '.jpg'));
        end
    end
end
