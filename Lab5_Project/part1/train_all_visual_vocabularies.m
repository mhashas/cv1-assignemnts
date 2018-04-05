sift_types = [0];
color_spaces = [ "RGB", "rgb",  "opponent", "gray"];
vocabulary_sizes = [400, 800, 1600, 2000, 4000];
vocabulary_images = 200;
max_features = 50 * vocabulary_images * 4;
max_iter = 500;

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
                
                save(sprintf('saved_vocabs/%d_images_%d_vocabsize_%s_%s.mat', vocabulary_images, k, dense_string, color), 'centers');
            catch e
                warning('ERROR! Failed to build vocab %d_images_%d_vocabsize_%s_%s.mat\n%s', vocabulary_images, k, dense_string, color, e.message);
            end
        end
    end
end
