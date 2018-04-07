sift_types = [0]; % 0 or 1 for dense or normal sift
color_spaces = ["RGB", "rgb", "gray", "opponent"];
% if set to 1, we extract keypoints from gray image and the descriptors of those keypoint from image transformed into colorspace. 
% else we extract descriptors directly from image transformed into colorspace
extract_from_gray = 0;
vocabulary_sizes = [400, 800, 1600, 2000, 4000]; % k in kmeans
vocabulary_images = 200; % number of images used for training the vocabulary
max_features = 50 * vocabulary_images * 4; % max number of features 
max_iter = 500; % max number of iterations for kmeans
test_images_per_class = 50;


k = 400;
dense_string = 'normal';
color = "RGB";
train_images_per_class = 200;

vocab_location = sprintf('saved_vocabs/%d_images_%d_vocabsize_%s_%s.mat', vocabulary_images, k, dense_string, color);
load(vocab_location, 'centers');

if ~centers
    disp('YOOOOO');
else
    [classifiers, test_set, test_features] = train_classifier(vocabulary_images, train_images_per_class, test_images_per_class, 0, color, k, max_features, centers);
    mAP = evaluate(classifiers, test_set, test_features, test_images_per_class);
end