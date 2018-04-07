function [vocabulary_images, dataset_images] = get_images(dataset_directory, nr_vocab_images, nr_dataset_images)
    images = dir(strcat(dataset_directory, '*.jpg'));
    total_images = length(images);

    if nargin < 3
        nr_dataset_images = 50;
    end

    vocabulary_images = [];
    dataset_images = [];

    for i=1:total_images
        file = strcat(dataset_directory, images(i).name);
        image = imread(file); 
        all_images{i} = image;
    end

    for i=1:nr_vocab_images
        vocabulary_images{i} = all_images{i};
    end

    if nr_vocab_images + nr_dataset_images > total_images
        nr_unique_images = total_images - nr_vocab_images;
        needs_vocab_images = 1;
    else
        needs_vocab_images = 0;
    end
    
    if needs_vocab_images
        for i=1:nr_unique_images
            dataset_images{i} = all_images{i + nr_vocab_images};
        end
    
        copy_vocab_images = vocabulary_images;
        % randomize remaining images
        copy_vocab_images = copy_vocab_images';
        copy_vocab_images = copy_vocab_images(randperm(length(copy_vocab_images)));	     
        copy_vocab_images = copy_vocab_images';

        nr_images_left_to_add = nr_vocab_images + nr_dataset_images - total_images;

        for i=1:nr_images_left_to_add
            dataset_images = [dataset_images, copy_vocab_images{i}];
        end
    else
        for i=1:nr_dataset_images
            dataset_images{i} = all_images{i + nr_vocab_images};
        end
    end
end