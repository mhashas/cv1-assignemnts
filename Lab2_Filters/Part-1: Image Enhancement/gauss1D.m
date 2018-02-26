function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    mu =  floor(kernel_size/2);
    for i = 1:kernel_size
        x = i - mu - 1;
        G(i) = x*x;
    end
    G = 1/(sqrt(2*pi)*sigma)*exp(G*(-1/(2*sigma*sigma)));
    G = G/sum(G);
end
