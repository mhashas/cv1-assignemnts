colorspace = "RGB";
dense = 0;
test_images_per_class = 50;

file_name = 'trained_classifiers/200_images_2000_vocabsize_200_training_images_normal_RGB.mat';
vocab = 'saved_vocabs/200_images_2000_vocabsize_normal_RGB.mat';

load(vocab, 'centers');
load(file_name, 'classifiers');




[~, ~, test_set] = load_dataset(0, 0);
test_features = build_features(test_set, centers, colorspace, dense, test_images_per_class);


mAP = evaluate(classifiers, test_set, test_features, test_images_per_class);