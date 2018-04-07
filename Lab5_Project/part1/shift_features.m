function [shifted_features] = shift_features(features, images_per_class, class, nr_classes)
    % move features around so the features for the class we are currently
    % training are first
    
    shift = images_per_class * (nr_classes-class+1);
    
    shifted_features = circshift(features, shift);

end