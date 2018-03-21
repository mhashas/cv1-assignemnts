function [returned_images] = get_images(dataset_directory, number_of_images)
    images = dir(strcat(dataset_directory, '*.jpg'));
    returned_images = [];
    
    if strcmp(number_of_images, 'all') == 1
        number_of_images = length(images);
    end
    
    for i=1:2
        file = strcat(dataset_directory, images(i).name);
        image = imread(file);
        
        % preprocess image as needed !!!
        
        returned_images{i} = image;
        
    end
end