function [classifiers, test_set, test_features] =  train_classifier(vocabulary_images, train_images_per_class, test_images_per_class, dense, colorspace, vocabulary_size, max_features, compute_test, centers)

if nargin < 8
    centers = 0;
    compute_test = 1;
end

[train_vocab_set, train_set, test_set] = load_dataset(vocabulary_images, train_images_per_class);
test_features = {};

if ~centers
    %% COLLECT SIFT FEATURES
    descriptors = extract_sift_features(train_vocab_set, colorspace, dense, max_features);

    %% BUILD VISUAL VOCAB
    [~, centers] = build_visual_vocab(descriptors, vocabulary_size);
end

%% BUILD FEATURES
train_features = build_features(train_set, centers, colorspace, dense, train_images_per_class);
if compute_test
    test_features = build_features(test_set, centers, colorspace, dense, test_images_per_class);
end
%% TRAIN SVMs 
classifiers = {};


whateva = ones(1, train_images_per_class);
whateva_2 = ones(1, train_images_per_class) * 2;
whateva_3 = ones(1, train_images_per_class)*3;
whateva_4 = ones(1, train_images_per_class)*4;

whateva = [whateva, whateva_2];
whateva = [whateva, whateva_3];
whateva = [whateva, whateva_4];

for i = 1:4

    train_features_i = train_features((i-1)*train_images_per_class +1:i*train_images_per_class);
    
    shifted_features = shift_features(train_features, train_images_per_class, i, 4);

    
    shifted_features_i = shifted_features(1:50);
    
    disp(isequal(shifted_features_i, train_features_i));
end
for i = 1:4
    labels = zeros(1, train_images_per_class*4);
    
    % positive class always first 
    labels(1: train_images_per_class) = ones(1, train_images_per_class);
    labels = double(labels);
    
    shifted_features = shift_features(train_features, train_images_per_class, i, 4);
    
    best = train(labels', sparse(shifted_features), '-C -s 0');
    classifiers{i} = train(labels', sparse(train_features), sprintf('-c %f -s 0', best(1) + 0.00001));   
end

end