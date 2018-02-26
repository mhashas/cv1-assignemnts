function [ PSNR ] = myPSNR( orig_image, approx_image )
    orig_image = double(orig_image);
    approx_image = double(approx_image);
    [n, m] = size(orig_image);
    imax = max(max(orig_image));
    error = sqrt(1/(n*m) * sum(sum((orig_image - approx_image).*(orig_image - approx_image))));
    PSNR = 20*log10(imax./error);
end

