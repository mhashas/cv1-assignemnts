function imOut = compute_LoG(image, LOG_type, argin)

switch LOG_type
    case 1
        %method 1
        g_filter = gauss2D(0.5, 5);
        l_filter = fspecial('laplacian');
        imOut = apply_kernel(apply_kernel(image,g_filter),l_filter);
    case 2
        %method 2
        log_filter = fspecial('log',5, 0.5);
        imOut = apply_kernel(image,log_filter);
    case 3
        %method 3
        s1 = argin(1);
        s2 = argin(2);
        g_filter1 = gauss2D(s1, 5);
        g_filter2 = gauss2D(s2, 5);
        imOut = apply_kernel(image,g_filter2) - apply_kernel(image,g_filter1);

%imshow(imfilter(imread('./images/image1.jpg'),fspecial('gaussian', 5, 0.5)))
%imshow(apply_kernel(imread('./images/image1.jpg'),fspecial('gaussian', 5, 0.5)))

end
end

