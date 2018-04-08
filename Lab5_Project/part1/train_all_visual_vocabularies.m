sift_types = [0,1]; % 0 or 1 for dense or normal sift
color_spaces = ["rgb"];
% if set to 1, we extract keypoints from gray image and the descriptors of those keypoint from image transformed into colorspace. 
% else we extract descriptors directly from image transformed into colorspace
extract_from_gray = 1;
vocabulary_sizes = [400, 800, 1600, 2000, 4000]; % k in kmeans
vocabulary_images = 200; % number of images used for training the vocabulary
max_features = 50 * vocabulary_images * 4; % max number of features 
max_iter = 500; % max number of iterations for kmeans

for dense = sift_types
    if dense
        dense_string = 'dense';
    else 
        dense_string = 'normal'; 
    end
    
    for color = color_spaces
        disp(sprintf('Loading dataset for %s' , color));
        
        [train_vocab_set, ~, ~] = load_dataset(vocabulary_images, 0);
        
        disp(sprintf('Extracting features'));

        tic;
        descriptors = extract_sift_features(train_vocab_set, color, dense, max_features);
        toc;
        for k = vocabulary_sizes
            try
                disp(sprintf('Building vocab %d', k));
                tic;
                [~, centers] = build_visual_vocab(descriptors, k, max_iter);
                toc;
                vocab_name = sprintf('saved_vocabs/%d_images_%d_vocabsize_%s_%s.mat', vocabulary_images, k, dense_string, color);
                save(vocab_name, 'centers');
            catch e
                warning('ERROR! Failed to build vocab %d_images_%d_vocabsize_%s_%s.mat\n%s', vocabulary_images, k, dense_string, color, e.message);
            end
        end
    end
end
