function histogram = build_histogram(centers, image, colorspace, dense)
% centers: 2D array cluster centers (vocabulary words centers)
% centers: 128 X number of centers

histogram = zeros(size(centers,2),1);
%% get all the sift features
[~, d] = get_image_features(image, colorspace, dense, size(centers,1));

%% assign each feature to a cluster and count
for feature_idx = 1,size(d,2);
    feature = d(:, feature_idx);
    [~, k] = min(vl_alldist(feature, centers));
    histogram(k) = histogram(k) + 1;
end
%normalize histogram
histogram = histogram / sum(histogram); 