sift_types = [0, 1]; % 0 or 1 for dense or normal sift
color_spaces = ["rgb", "RGB", "gray", "opponent"];
% if set to 1, we extract keypoints from gray image and the descriptors of those keypoint from image transformed into colorspace. 
% else we extract descriptors directly from image transformed into crspace
extract_from_gray = 0;
vocabulary_sizes = [400, 800, 1600, 2000, 4000]; % k in kmeans
train_images_sizes = [50, 100, 200 , 300, 400]; 
vocabulary_images = 200; % number of images used for training the vocabulary
max_features = 50 * vocabulary_images * 4; % max number of features 
max_iter = 500; % max number of iterations for kmeans
test_images_per_class = 50;

for dense = sift_types
    if dense
        dense_string = 'dense';
    else 
        dense_string = 'normal'; 
    end

     for color = color_spaces
         for k = vocabulary_sizes
            vocab_location = sprintf('saved_vocabs/%d_images_%d_vocabsize_%s_%s.mat', vocabulary_images, k, dense_string, color);
            load(vocab_location, 'centers');

            disp(sprintf('Loaded vocab %s %s %d', color, dense_string, k));

            for train_images_per_class = train_images_sizes
                tic
                
                disp(sprintf('Evaluating for training size %d', train_images_per_class));

                classifier_name = sprintf('trained_classifiers/%d_images_%d_vocabsize_%d_training_images_%s_%s.mat', vocabulary_images, k, train_images_per_class, dense_string, color);
                load(classifier_name, 'classifiers');
                
                [~, ~, test_set] = load_dataset(0, 0);
                test_features = build_features(test_set, centers, colorspace, dense, test_images_per_class);
                [mAP, predicted_labels, class_features]  = evaluate(classifiers, test_set, test_features, test_images_per_class);

                toc
            end
         end
     end
end