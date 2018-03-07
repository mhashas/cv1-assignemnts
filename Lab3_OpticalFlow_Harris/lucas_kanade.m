function [Vx, Vy] = lucas_kanade(image1, image2, Xs, Ys, window_size)
if length(size(image1)) == 3
    image1 = rgb2gray(image1);
    image2 = rgb2gray(image2);
end
image1 = double(image1);
image2 = double(image2);

G = fspecial('gaussian', 5, 0.5);
derivative = -[-1/2; 0; 1/2];

% convolve with 0-padding, result in same size
Gx = imfilter(G, derivative, 0, 'same', 'conv');
Gy = imfilter(G, derivative', 0, 'same', 'conv');

Ix = imfilter(image2, Gx, 0, 'same', 'conv');
Iy = imfilter(image2, Gy, 0, 'same', 'conv');
It = image2 - image1;

mask_radius = floor(window_size/2);
Vx = zeros(size(Xs));
Vy = zeros(size(Ys));

[N, M] = size(image1);
for i = 1:length(Ys)
    % for each window (i-1)*15+1:i*15, (j-1)*15+1:j*15 

    start_i = Ys(i)-mask_radius;
    end_i = Ys(i)+mask_radius;
    start_j = Xs(i)-mask_radius;
    end_j = Xs(i)+mask_radius;
    
    if start_i < 1 || start_j < 1 || end_i > N || end_j > M
       Vx(i) = 0;
       Vy(i) = 0;
       continue
    end

    Ix_mask = Ix(start_i:end_i, start_j:end_j);
    Iy_mask = Iy(start_i:end_i, start_j:end_j);
    It_mask = It(start_i:end_i, start_j:end_j);

    A = [Ix_mask(:) Iy_mask(:)];
    b = -It_mask(:);
    v = (A'*A)^(-1);
    v = v*A'*b;

    Vx(i) = v(2);
    Vy(i) = v(1);
end
end

