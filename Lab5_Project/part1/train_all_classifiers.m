    sift_types = [0]; % 0 or 1 for dense or normal sift
    color_spaces = ["RGB", "rgb", "gray", "opponent"];
    % if set to 1, we extract keypoints from gray image and the descriptors of those keypoint from image transformed into colorspace. 
    % else we extract descriptors directly from image transformed into colorspace
    extract_from_gray = 0;
    vocabulary_sizes = [400, 800, 1600, 2000, 4000]; % k in kmeans
    train_images_sizes = [50, 100, 150, 200, 300, 400]; 
    vocabulary_images = 200; % number of images used for training the vocabulary
    max_features = 50 * vocabulary_images * 4; % max number of features 
    max_iter = 500; % max number of iterations for kmeans

    k = 400;
    dense_string = 'normal';
    color = "RGB";
    train_images_per_class = 200;


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
                
                for train_images_per_class = train_images_sizes
                    [classifiers, ~, ~] = train_classifier(vocabulary_images, train_images_per_class, 0, dense, color, k, max_features, 0, centers);
                    classifier_name = sprintf('trained_classifiers/%d_images_%d_vocabsize_%d_training_images%s_%s.mat', vocabulary_images, k, train_images_per_class, dense_string, color);
                    save(classifier_name, 'classifiers'); 
                end
             end
         end
    end