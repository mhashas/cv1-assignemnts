function [Vx, Vy] = lucas_kanade(image1, image2)
if length(size(image1)) == 3
    image1 = rgb2gray(image1);
    image2 = rgb2gray(image2);
end
image1 = double(image1);
image2 = double(image2);
[N, M] = size(image1);

G = fspecial('gaussian', 5, 0.5);
derivative = -[-1/2; 0; 1/2];

% convolve with 0-padding, result in same size
Gx = imfilter(G, derivative', 0, 'same', 'conv');
Gy = imfilter(G, derivative, 0, 'same', 'conv');

Ix = imfilter(image2, Gx, 0, 'same', 'conv');
Iy = imfilter(image2, Gy, 0, 'same', 'conv');
It = image2 - image1;

Vx = zeros(floor(N/15), floor(N/15));
Vy = zeros(floor(M/15), floor(M/15));

for i = 1:floor(N/15)
    for j = 1:floor(M/15)
        % for each window (i-1)*15+1:i*15, (j-1)*15+1:j*15 
        start_i = (i-1)*15+1;
        end_i = i*15;
        start_j = (j-1)*15+1;
        end_j = j*15;
        
        Ix_mask = Ix(start_i:end_i, start_j:end_j);
        Iy_mask = Iy(start_i:end_i, start_j:end_j);
        It_mask = It(start_i:end_i, start_j:end_j);
        
        A = [Ix_mask(:) Iy_mask(:)];
        b = -It_mask(:);
        v = pinv(A'*A);
        v = v*A'*b;
        
        Vx(i,j) = v(1);
        Vy(i,j) = v(2);
    end
end
end

