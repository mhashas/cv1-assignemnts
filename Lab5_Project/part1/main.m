clear
clc
close all

%user defined variables
number_of_images = 50;
dense = true; % true if we should extract SIFT descriptors densely
colorspace = 'rgb' % possible values are: gray, rgb, RGB, opponent 

dataset = load_dataset(number_of_images);

for i