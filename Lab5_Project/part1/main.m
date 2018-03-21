clear
clc
close all

cars_train = './Caltech4/ImageData/cars_train/';
airplane_train = './Caltech4/ImageData/airplanes_train/';
faces_train = './Caltech4/ImageData/faces_train/';
motorbikes_train = './Caltech4/ImageData/motorbikes_train/';


images = get_images(cars_train, 50);
disp(length(images));