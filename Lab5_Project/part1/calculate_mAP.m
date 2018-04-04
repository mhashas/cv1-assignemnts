function [map] =  calculate_mAP(actual_labels, predicted_labels)
    prec = 0;
    count = 0;
    
    for i=1:length(actual_labels)
        if actual_labels(i) == 1 && predicted_labels(i) == 1
            count = count + 1;
            prec = prec + ( count / i);
        end
    end
    map = prec / sum(actual_labels==1);
end
