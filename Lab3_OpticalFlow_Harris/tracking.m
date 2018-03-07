function tracking(image_set_name, image_ext, name_0_padding, image_range, save_frames)

%%
% Parameters that could be changed
g1_sigma = 0.8;
g1_size = 9;
g2_sigma = 0.3;
g2_size = 9;

k = 0.04;
supression_size = 15;
top_N = 250;
method = 'Harris';

flow_scaling = 1;

%%
% Tracking algorithm


image1 = imread(strcat(image_set_name, '/', pad(num2str(1), name_0_padding, 'left','0'), '.', image_ext));
[~, ~, ~, rows, columns] = harris_corner_detector(image1, g1_sigma, g1_size, g2_sigma, g2_size, k, supression_size, top_N, method);

f = figure('visible', 'off');
imshow(image1)
hold all
plot(rows,columns,'ro', 'MarkerSize', 5)

if save_frames == 1
    if isdir(strcat(image_set_name, '_tracking/')) == 0
        mkdir(strcat(image_set_name, '_tracking/'));
    end
end

for i = 2:image_range
    image2 = imread(strcat(image_set_name, '/', pad(num2str(i), name_0_padding, 'left','0'), '.', image_ext));    
    [Vx, Vy] = lucas_kanade(image1,image2, floor(rows), floor(columns), supression_size);
    imshow(image2)
    
    quiver(floor(rows),floor(columns),Vx,Vy)
    rows = rows + flow_scaling*Vx;
    columns = columns + flow_scaling*Vy;
    plot(rows,columns,'ro', 'MarkerSize', 5)
    if save_frames == 1
        %savefig(gcf,strcat(image_set_name, '_tracking/', pad(num2str(i), name_0_padding, 'left','0'), '.', 'fig'));
        saveas(gcf,strcat(image_set_name, '_tracking/', pad(num2str(i), name_0_padding, 'left','0'), '.', 'jpg'));
    end
    pause(0.01)
    image1 = image2;

end
close(f)
end

