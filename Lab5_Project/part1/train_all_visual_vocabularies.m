sift_types = [0, 1];
color_spaces = [ "RGB", "rgb",  "opponent", "gray"];
vocabulary_sizes = [400, 800, 1600, 2000, 4000];
vocabulary_images = 250;
max_features = 200 * vocabulary_images * 4;

for dense = sift_types
    if dense
        dense_string = 'dense';
    else 
        dense_string = 'normal'; 
    end
    
    for color = color_spaces
        [train_vocab_set, train_set, ~] = load_dataset(1, 1);
        
        tic;
        descriptors = extract_sift_features(train_vocab_set, color, dense, max_features);
        toc;
        for k = vocabulary_sizes
            try
                disp('Building vocab');
                tic;
                [~, centers] = build_visual_vocab(descriptors, k);
                toc;
                
                save(sprintf('saved_vocabs/%d_images_%d_vocabsize_%s_%s.mat', vocabulary_images, k, dense_string, color), 'centers');
                save(sprintf('train_set/%d_images_%d_vocabsize_%s_%s.mat', vocabulary_images, k, dense_string, color), 'train_set');
            catch e
                warning('ERROR! Failed to build vocab %d_images_%d_vocabsize_%s_%s.mat\n%s', vocabulary_images, k, dense_string, color, e.message);
            end
        end
    end
end
