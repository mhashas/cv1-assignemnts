function [Ix, Iy, H, rows, columns] = harris_corner_detector(image, g1_sigma, g1_size, g2_sigma, g2_size, k, window_size, top_N, method)
%method = 'Eigen' | 'Harris' | 'Shi-Tomasi'
image = rgb2gray(image);

G = fspecial('gaussian', g1_size, g1_sigma);
derivative = [ -1/2; 0; 1/2];

% convolve with 0-padding, result in same size
Gx = imfilter(G, derivative, 0, 'same', 'conv');
Gy = imfilter(G, derivative', 0, 'same', 'conv');

Ix = imfilter(image, Gx, 0, 'same', 'conv');
Iy = imfilter(image, Gy, 0, 'same', 'conv');

G = fspecial('gaussian', g2_size, g2_sigma);
A = imfilter(Ix.*Ix, G, 0, 'same', 'conv');
C = imfilter(Iy.*Iy, G, 0, 'same', 'conv');
B = imfilter(Ix.*Iy, G, 0, 'same', 'conv');

switch method
    case 'Harris'
        H = (A.*C - B.*B) - k*((A+C).^2);
        
    case 'Eigen'
        [N, M] = size(image);
        H = zeros([N,M]);
        for i = 1:N
            for j = 1:M
                [~, D] = eig(double([A(i,j) B(i,j); B(i,j) C(i,j)]));
                H(i,j) = det(D) - k*trace(D)*trace(D);
            end
        end
        
    case 'Shi-Tomasi'
        [N, M] = size(image);
        H = zeros([N,M]);
        for i = 1:N
            for j = 1:M
                [~, D] = eig(double([A(i,j) B(i,j); B(i,j) C(i,j)]));
                H(i,j) = min([D(1,1) D(2,2)]);
            end
        end
        
end

H = nms(H, window_size, top_N);

[columns, rows] = find(H ~= 0);
end

