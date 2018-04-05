function [idx, C] = build_visual_vocab(descriptors, k)
    [C, idx] = vl_kmeans(descriptors, k);
    C = normr(C);
end