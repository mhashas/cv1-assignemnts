function G = gauss2D( sigma , kernel_size )
    %% solution
    g1D = gauss1D(sigma,kernel_size);
    G = zeros(kernel_size, kernel_size);
    for i = 1:kernel_size
        for j = 1:kernel_size
            G(i,j) = g1D(i) * g1D(j);
        end
    end
end