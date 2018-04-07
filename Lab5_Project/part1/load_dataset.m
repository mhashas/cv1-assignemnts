function [dataset_train_vocab, dataset_train, dataset_test] = load_dataset(nr_vocab_images, nr_dataset_images)
cars_train = '../Caltech4/ImageData/cars_train/';
airplanes_train = '../Caltech4/ImageData/airplanes_train/';
faces_train = '../Caltech4/ImageData/faces_train/';
motorbikes_train = '../Caltech4/ImageData/motorbikes_train/';

%% Returned trained images are an array of size 2 {vocabulary_images, training_images}
[airplanes_vocab, airplanes_train] = get_images(airplanes_train, nr_vocab_images, nr_dataset_images);
[cars_vocab, cars_train] = get_images(cars_train, nr_vocab_images, nr_dataset_images);
[faces_vocab, faces_train] = get_images(faces_train, nr_vocab_images, nr_dataset_images);
[motorbikes_vocab, motorbikes_train] = get_images(motorbikes_train, nr_vocab_images, nr_dataset_images);

dataset_train = {airplanes_train cars_train faces_train motorbikes_train};
dataset_train_vocab = {airplanes_vocab cars_vocab faces_vocab motorbikes_vocab};

%% Returned test images  
cars_test = '../Caltech4/ImageData/cars_test/';
airplanes_test = '../Caltech4/ImageData/airplanes_test/';
faces_test = '../Caltech4/ImageData/faces_test/';
motorbikes_test = '../Caltech4/ImageData/motorbikes_test/';

[~, airplanes_test] = get_images(airplanes_test, 0);
[~, cars_test] = get_images(cars_test, 0);
[~, faces_test] = get_images(faces_test, 0);
[~, motorbikes_test] = get_images(motorbikes_test, 0);

dataset_test = {airplanes_test cars_test faces_test motorbikes_test};

end