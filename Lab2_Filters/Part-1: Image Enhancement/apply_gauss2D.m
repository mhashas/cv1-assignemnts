function conv_img = apply_gauss2D( image, sigma, kernel_size )
    [n, m] = size(image);
    half_k = floor(kernel_size/2);
    conv_img = zeros(n, m);
    kernel = gauss2D(sigma,kernel_size);
    image = im2double(image);
    for i = half_k+1:n-half_k
        for j = half_k+1:m-half_k
            conv_img(i,j) = sum(sum(kernel.*image(i-half_k:i+half_k,j-half_k:j+half_k))); 
        end
    end
end