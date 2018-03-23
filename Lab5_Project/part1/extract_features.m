function [keypoints, descriptors] = extract_features(dataset, colorspace, dense, sample_random_image_features, sample_size)

descriptors = [];
keypoints = [];

for i=1:size(dataset, 2)
    
    image = im2single(dataset{i});
    
    [d, k] = get_image_features(image, colorspace, dense);
    
    %sample 200 random descriptors for each image
    if sample_random_image_features
        if sample_size < size(d,2)
            sample_idxs = randsample(size(d,2), sample_size);
            k = k(:, sample_idxs);
            d = d(:, sample_idxs);
        end
    end
    keypoints = [keypoints, k];
    descriptors = [descriptors, d];
end

end