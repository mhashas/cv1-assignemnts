function [dataset] = load_dataset(number_of_images)
cars_train = './Caltech4/ImageData/cars_train/';
airplanes_train = './Caltech4/ImageData/airplanes_train/';
faces_train = './Caltech4/ImageData/faces_train/';
motorbikes_train = './Caltech4/ImageData/motorbikes_train/';

airplanes = get_images(airplanes_train, number_of_images);
cars = get_images(cars_train, number_of_images);
faces = get_images(faces_train, number_of_images);
motorbikes = get_images(motorbikes_train, number_of_images);

dataset = {airplanes cars faces motorbikes};

end