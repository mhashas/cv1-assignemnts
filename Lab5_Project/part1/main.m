clear
clc
close all

%user defined variables
number_of_images = 2;
dense = 1; % true if we should extract SIFT descriptors densely
colorspace = 'opponent'; % possible values are: gray, rgb, RGB, opponent 

complete_dataset = load_dataset(number_of_images);

sample_random_image_features = 1;
sample_size = 200;
descriptors = [];
for class = 1:4
    [~, class_descriptors] = extract_features(complete_dataset{class}, colorspace, dense, sample_random_image_features, sample_size);
    descriptors = [descriptors, class_descriptors];
end