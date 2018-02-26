function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
    [n, m] = size(image);
    half_k = 1;
    Gx = zeros(n, m);
    Gy = zeros(n, m);
    im_magnitude = zeros(n, m);
    im_direction = zeros(n, m);
    kernel_Gx = [1 0 -1; 2 0 -2; 1 0 -1];
    kernel_Gy = [1 2 1; 0 0 0; -1 -2 -1];
    image = im2double(image);
    
    
    for i = half_k+1:n-half_k
        for j = half_k+1:m-half_k
            Gx(i,j) = sum(sum(kernel_Gx.*image(i-half_k:i+half_k,j-half_k:j+half_k))); 
            Gy(i,j) = sum(sum(kernel_Gy.*image(i-half_k:i+half_k,j-half_k:j+half_k))); 
            im_magnitude(i,j) = sqrt(Gx(i,j)^2 + Gy(i,j)^2);
            im_direction(i,j) = atanh(Gy(i,j)/Gx(i,j));
        end
    end
end

