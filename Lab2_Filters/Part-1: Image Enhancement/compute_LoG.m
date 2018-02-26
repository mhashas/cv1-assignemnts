function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        fprintf('Not implemented\n')
        imOut = apply_gauss2D(image,0.5,5);
        imOut = apply_kernel(conv_image,[0 1 0; 1 -4 1; 0 1 0]);
    case 2
        %method 2
        fprintf('Not implemented\n')
        kernel = 
    case 3
        %method 3
        fprintf('Not implemented\n')

end
end

