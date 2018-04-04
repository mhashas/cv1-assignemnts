function [features] = build_features(dataset, centers, colorspace, dense, images_per_class)
%% GET HISTOGRAMS OF IMAGES
features = zeros(images_per_class*4, size(centers,2));
for class = 1:4
    for image_idx = 1:images_per_class
        image = dataset{class}{image_idx};
        histogram = build_histogram(centers, image, colorspace, dense);
        
        data_idx = (class-1)*images_per_class + image_idx;
        features(data_idx, :) = histogram';
    end
end
end