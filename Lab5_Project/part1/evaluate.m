function [mAP] = evaluation(classifiers, test_set, test_features, test_images_per_class)

mAP = ones(1, 4);
    for class=1:4
        disp(sprintf('Evaluation for class %d', class));
        
        labels = zeros(1, test_images_per_class*4);
        labels((class-1)*test_images_per_class+1:(class)*test_images_per_class) = ones(1, test_images_per_class);
        
        [predicted_labels, ~, class_scores] = predict(labels', sparse(test_features), classifiers{class});
        mAP(class) = calculate_mAP(labels, predicted_labels);
    end

end