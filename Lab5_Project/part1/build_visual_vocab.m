function [idx, C] = build_visual_vocab(descriptors, k, dense)
    if dense
        [C, idx] = vl_kmeans(descriptors, k);
    else
        [idx, C] = kmeans(descriptors', k, 'Start', 'cluster');
    end
    C = normr(C);
end