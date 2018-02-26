function conv_img = apply_kernel(image, kernel)
    [n, m] = size(image);
    [kernel_size, ~] = size(kernel);
    half_k = floor(kernel_size/2);
    conv_img = zeros(n, m);
    image = im2double(image);
    padded_image = zeros(n+2*half_k,m+2*half_k);
    padded_image(half_k+1:half_k+n,half_k+1:half_k+m) = image;
    for i = 1:n
        for j = 1:m
            conv_img(i,j) = sum(sum(kernel.*padded_image(i:i+2*half_k,j:j+2*half_k))); 
        end
    end
end

