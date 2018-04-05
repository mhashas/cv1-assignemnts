function [idx, C] = build_visual_vocab(descriptors, k, max_iter)
    if nargin < 3
        max_iter = 0; 
    end
        
    if max_iter
        [C, idx] = vl_kmeans(descriptors, k, 'MaxNumIterations', max_iter);
    else
        [C, idx] = vl_kmeans(descriptors, k);
    end
    C = normr(C);
end