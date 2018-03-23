clear
clc
close all

%% LOAD DATA
%user defined variables
images_per_class = 2;
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
size(centers)
size(assignments)

%% GET HISTOGRAMS OF IMAGES
data = zeros(size(centers,2),number_of_images*4);

for class = 1:4
    for image_idx = 1:number_of_images
        image = complete_dataset{class}{image_idx};
        histogram = image_feature_histogram(centers, image, colorspace, dense);
        
        data_idx = (class-1)*number_of_images + image_idx;
        data(:, data_idx) = histogram;
        labels(data_idx) = class;
    end
end

%% TRAIN 4 SVMs 
classifiers = {};
for i = 1:4
    labels = zeros(1, number_of_images*4);
    labels((i-1)*number_of_images: (i)*number_of_images - 1) = ones(number_of_images);
    [w b info] = vl_svmtrain(data, labels);
    classifiers{i}{1} = w;
    classifiers{i}{2} = b;
end
