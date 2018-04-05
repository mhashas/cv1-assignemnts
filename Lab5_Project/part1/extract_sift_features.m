function [features] = extract_sift_features(complete_dataset, colorspace, dense, max_features)

features = [];

for class = 1:4
    dataset = complete_dataset{class};
    descriptors = [];
    
    for i=1:size(dataset, 2)
        image = im2single(dataset{i});
        [~, d] = get_image_features(image, colorspace, dense, max_features);
        
        descriptors = [descriptors, d];
    end
    features = [features, descriptors];
end
