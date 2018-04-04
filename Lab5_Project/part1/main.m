clear
clc
close all

%user defined variables
number_of_images = 50;
images_per_class = 50;
dense = true; % true if we should extract SIFT descriptors densely
colorspace = 'opponent'; % possible values are: gray, rgb, RGB, opponent 
vocabulary_size = 400; % k in kmeans

  
[train_set, test_set] = load_dataset(number_of_images);


%% COLLECT SIFT FEATURES
descriptors = [];
for class = 1:4
    class_descriptors = extract_features(train_set{class}, colorspace, dense, 1200);
    descriptors = [descriptors, class_descriptors];
end

[idx, centers] = build_visual_vocab(descriptors, vocabulary_size, dense);



%% GET HISTOGRAMS OF IMAGES
data = zeros(size(centers,2), images_per_class*4);
for class = 1:4
    for image_idx = 1:images_per_class
        image = train_set{class}{image_idx};
        histogram = build_histogram(centers, image, colorspace, dense);
        
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
    [w, b, info] = vl_svmtrain(data, labels, lambda);
    
    classifiers{i}{1} = w;
    classifiers{i}{2} = b;
end