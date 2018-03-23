clear
clc
close all

%% LOAD DATA
%user defined variables
images_per_class = 3;
dense = 1; % true if we should extract SIFT descriptors densely
colorspace = 'opponent'; % possible values are: gray, rgb, RGB, opponent 

complete_dataset = load_dataset(images_per_class);
% complete dataset: {cars}, {planes}, etc.
% cars: {img1}, {img2}, etc.
% img1: H X W X 3

%% COLLECT SIFT FEATURES
sample_random_image_features = 1;
sample_size = 200;
descriptors = [];
for class = 1:4
    [~, class_descriptors] = extract_features(complete_dataset{class}, colorspace, dense, sample_random_image_features, sample_size);
    descriptors = [descriptors, class_descriptors];
end

%% CLUSTER FEATURES
vocab_size = 1000;
[centers, assignments] = vl_kmeans(descriptors, vocab_size, 'Initialization', 'plusplus', 'Algorithm' ,'Lloyd');

%% GET HISTOGRAMS OF IMAGES
data = zeros(size(centers,2), images_per_class*4);
for class = 1:4
    for image_idx = 1:images_per_class
        image = complete_dataset{class}{image_idx};
        histogram = image_feature_histogram(centers, image, colorspace, dense);
        
        data_idx = (class-1)*images_per_class + image_idx;
        data(:, data_idx) = histogram;
    end
end

%% TRAIN 4 SVMs 
classifiers = {};
lambda = 0.01;
for i = 1:4
    labels = zeros(1, images_per_class*4);
    labels((i-1)*images_per_class+1: (i)*images_per_class) = ones(1, images_per_class);
    [w b info] = vl_svmtrain(data, labels, lambda);
    classifiers{i}{1} = w;
    classifiers{i}{2} = b;
end

% classifier: {classifier1}, {classifier2}, etc.
% classifier{1}: {w} {b}
% w: num centers X 1
% b: 1 X 1
