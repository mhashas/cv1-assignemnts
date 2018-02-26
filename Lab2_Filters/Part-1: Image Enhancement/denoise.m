function [ imOut ] = denoise( image, kernel_type, argin)
    switch kernel_type
        case 'box'
            imOut = imboxfilt(image, argin(1));
        case 'median'
            imOut = medfilt2(image,[argin(1),argin(1)]);
        case 'gaussian'
            imOut = apply_gauss2D(image, argin(1), argin(2));
    end
end
