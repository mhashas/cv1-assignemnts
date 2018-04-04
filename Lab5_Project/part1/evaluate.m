function [] = evaluation(classifiers, test_set, test_features)
mAP = ones(1, 4);
    for class=1:4
        disp(sprintf('Evaluation for class %d', class));
        class_label = double(labels==class);
        [predicted_labels, ~, class_scores] = predict(class_label, sparse(features), classifiers{class});
        scores(class, :) = sort(class_scores);
        mAP(class) = calculate_MAP(class_label, predicted_labels);
    end

end