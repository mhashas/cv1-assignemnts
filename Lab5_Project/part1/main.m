clear
clc
close all

%% USER DEFINED FEATURES
vocabulary_images = 2; % number of images used for building the visual vocabulary
training_images_per_class = 2; % number of images for training the svm classifier
test_images_per_class = 2;
dense = true; % true if we should extract SIFT descriptors densely
colorspace = 'opponent'; % possible values are: gray, rgb, RGB, opponent 
vocabulary_size = 400; % k in kmeans
max_features = 200;


%% TRAIN CLASSIFIERS AND EVALUATE 
[classifiers, test_set, test_features] = train_classifier(vocabulary_images, training_images_per_class, test_images_per_class, dense, colorspace, vocabulary_size, max_features);
evaluate(classifiers, test_set, test_features);
