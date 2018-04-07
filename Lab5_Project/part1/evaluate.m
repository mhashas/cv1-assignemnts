function [mAP] = evaluation(classifiers, test_set, test_features)
mAP = ones(1, 4);
    for class=1:4
        disp(sprintf('Evaluation for class %d', class));
        
        labels = zeros(1, 50*4);
        labels((i-1)*50+1: (i)*50) = ones(1, 50);
        
        [predicted_labels, ~, class_scores] = predict(labels, sparse(test_features), classifiers{class});
        scores(class, :) = sort(class_scores);
        mAP(class) = calculate_MAP(class_label, predicted_labels);
    end

end