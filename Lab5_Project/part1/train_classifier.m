function [classifiers, test_set, test_features] =  train_classifier(vocabulary_images, train_images_per_class, test_images_per_class, dense, colorspace, vocabulary_size, max_features)

[train_vocab_set, train_set, test_set] = load_dataset(vocabulary_images, train_images_per_class);

%% COLLECT SIFT FEATURES
descriptors = extract_sift_features(train_vocab_set, colorspace, dense, max_features);

%% BUILD VISUAL VOCAB
[~, centers] = build_visual_vocab(descriptors, vocabulary_size);

%% BUILD FEATURES
train_features = build_features(train_set, centers, colorspace, dense, train_images_per_class);
%test_features = build_features(test_set, centers, colorspace, dense, test_images_per_class);

%% TRAIN SVMs 
classifiers = {};

for i = 1:4
    labels = zeros(1, train_images_per_class*4);
    labels((i-1)*train_images_per_class+1: (i)*train_images_per_class) = ones(1, train_images_per_class);
    labels = double(labels);
    
    classifiers{i} = train(labels', sparse(train_features), '-s 1');
   
end

end

%{ 

START TRAINING ASAP ON HOME COMPUTER
DO ONE MODEL ON HOME COMPUTER WHILE WRITTING CODE FOR TRAINING ALL
CLASSIFIERS

TRAIN ALL LINEAR CLASSIFIERS DURING DAY AND WRITE REPORT 

TRAIN ALL RBF CLASSIFIERS DURING NIGHT AND WRITE REPORT


GOD BLESS



%}