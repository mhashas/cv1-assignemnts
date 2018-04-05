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
        dataset_images{i} = image;
    end
    
    for i=1:nr_vocab_images
        vocabulary_images{i} = dataset_images{i};
    end
    
    % randomize images
    dataset_images = dataset_images';
    dataset_images = dataset_images(randperm(total_images));
    dataset_images = dataset_images';
    
    for i=1:nr_dataset_images
        dataset_images{i} = dataset_images{i + nr_vocab_images};
    end
end