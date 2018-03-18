function [best_transformation_matrix] = ransac(matches, f1, f2, N, P, radius)

best_transformation_matrix = [];
best_number_inliers = 0;

for i = 1:N
    subset = datasample(matches, P, 2);
   
    x1 = f1(1, subset(1,:));
    x2 = f2(1, subset(2,:));
    y1 = f1(2, subset(1,:));
    y2 = f2(2, subset(2,:));
    
    A = [];
    b = [];
    
    for i = 1:P
        A_i = [x1(i), y1(i), 0, 0, 1, 0; 0, 0, x1(i), y1(i), 0, 1];
        A = [A; A_i];
        
        b_i = [x2(i);y2(i)];
        b = [b; b_i];
    end
    
    x = pinv(A)*b;
    
    M = [x(1), x(2); x(3), x(4)];
    t = [x(5); x(6)];
    
    number_inliers = 0;
    
    for j = 1:length(matches)
        x_im1 = f1(1, matches(1,j));
        y_im1 = f1(2, matches(1,j));
        x_im2 = f2(1, matches(2,j));
        y_im2 = f2(2, matches(2,j));
        
        transformation = M*[x_im1;y_im1] + t;
        
        if abs(x_im2 - transformation(1)) < radius && abs(y_im2 - transformation(2)) < radius
            number_inliers = number_inliers + 1;
        end
        
        if best_number_inliers < number_inliers
            best_number_inliers = number_inliers;
            best_transformation_matrix = x;
        end
    end
end
end
