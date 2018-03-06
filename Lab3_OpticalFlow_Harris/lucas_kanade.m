function [Vx, Vy] = lucas_kanade(image1, image2)
image1 = double(rgb2gray(image1));
image2 = double(rgb2gray(image2));
[N, M] = size(image1);

G = fspecial('gaussian', 5, 0.5);
derivative = [ -1/2; 0; 1/2];

% convolve with 0-padding, result in same size
Gx = imfilter(G, derivative, 0, 'same', 'conv');
Gy = imfilter(G, derivative', 0, 'same', 'conv');

Vx = zeros(floor(N/15), floor(N/15));
Vy = zeros(floor(M/15), floor(M/15));
for i = 1:floor(N/15)
    for j = 1:floor(M/15)
        % for each window (i-1)*15+1:i*15, (j-1)*15+1:j*15 
        start_i = (i-1)*15+1;
        end_i = i*15;
        start_j = (j-1)*15+1;
        end_j = j*15;
        
        Ix = imfilter(image2(start_i:end_i, start_j:end_j), Gx, 0, 'same', 'conv');
        Iy = imfilter(image2(start_i:end_i, start_j:end_j), Gy, 0, 'same', 'conv');
        It = image2(start_i:end_i, start_j:end_j) - image1(start_i:end_i, start_j:end_j);
        
        A = [Ix(:) Iy(:)];
        b = -It(:);
        v = ((A'*A)^-1);
        v = v*A'*b;
        Vx(i,j) = v(2);
        Vy(i,j) = v(1);
    end
end
end

