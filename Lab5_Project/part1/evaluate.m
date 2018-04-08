function [mAP, predicted_labels, class_scores] = evaluation(classifiers, test_set, test_features, test_images_per_class)
mAP = ones(1, 4);
    for class=1:4
        disp(sprintf('Evaluation for class %d', class));
        labels = zeros(1, test_images_per_class*4);
        % positive class always first 
        labels(1: test_images_per_class) = ones(1, test_images_per_class);
        labels = double(labels);
        
        shifted_features = shift_features(test_features, test_images_per_class, class, 4);
        
        [predicted_labels, ~, class_scores] = predict(labels', sparse(shifted_features), classifiers{class});
        mAP(class) = calculate_mAP(labels, predicted_labels);
    end

end