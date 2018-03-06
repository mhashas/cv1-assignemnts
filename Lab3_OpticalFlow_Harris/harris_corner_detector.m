function [Ix, Iy, H, rows, columns] = harris_corner_detector(image, g_sigma, g_width, k, window_size, threshold, top_N)
image = rgb2gray(image);

G = fspecial('gaussian', g_width, g_sigma);
derivative = [ -1; 0; 1];

% convolve with 0-padding, result in same size
Gx = imfilter(G, derivative, 0, 'same', 'conv');
Gy = imfilter(G, derivative', 0, 'same', 'conv');

Ix = imfilter(image, Gx);
Iy = imfilter(image, Gy);

A = imfilter(Ix.*Ix, G, 0, 'same', 'conv');
C = imfilter(Iy.*Iy, G, 0, 'same', 'conv');
B = imfilter(Ix.*Iy, G, 0, 'same', 'conv');

%H = (A.*C - B.*B) - k*(A+C).^2;

[N, M] = size(image);
H = zeros([N,M]);

for i = 1:N
    for j = 1:M
        [~, D] = eig(double([A(i,j) B(i,j); B(i,j) C(i,j)]));
        H(i,j) = det(D) - k*trace(D)*trace(D);
    end
end

H = nms(H, window_size, threshold, top_N);

[columns, rows] = find(H ~= 0);
end

