clear
clc
close all

%user defined variables
number_of_images = 2;
dense = false; % true if we should extract SIFT descriptors densely
colorspace = 'opponent'; % possible values are: gray, rgb, RGB, opponent 

complete_dataset = load_dataset(number_of_images);

[~, features1] = extract_features(complete_dataset{1}, colorspace, dense); 

disp(isequal(features1, features2));

