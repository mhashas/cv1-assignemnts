function [descriptors] = extract_features(dataset, colorspace, dense, max_features)

descriptors = [];

for i=1:size(dataset, 2)
    image = im2single(dataset{i});
    [~, d] = get_image_features(image, colorspace, dense, max_features);
   
    descriptors = [descriptors, d];
end
end