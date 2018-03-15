img1 = im2double(imread('boat1.pgm'));
img2 = im2double(imread('boat2.pgm'));

[f1, f2, scores, matches, d1, d2] = keypoint_matching(img1, img2);

figure(2) ; clf ;
imshow(cat(2, img1, img2)) ;

plot_lines(f1, f2, matches, img1);

[trans_matrix] = ransac(img1, img2, matches, f1, f2, 3000, 150, 10);
trans_m = [trans_matrix(1), trans_matrix(2); trans_matrix(3), trans_matrix(4)];
trans_t = [trans_matrix(5); trans_matrix(6)];

tform_12 = maketform('affine', [transpose(trans_m); trans_t']);
tform_21 = maketform('affine', [trans_m; trans_t']);

transformed_im1 = imtransform(img1, tform_12);
transformed_im2 = imtransform(img2, tform_21);
figure;
% imshow(img1)
imshow(img2)
figure;
imshow(transformed_im1)
% imshow(transformed_im2)

function plot_lines(f1, f2, matches, img1)
subset = datasample(matches, 50, 2);

x1 = f1(1,subset(1,:)) ;
x2 = f2(1,subset(2,:)) + size(img1,2) ;
y1 = f1(2,subset(1,:)) ;
y2 = f2(2,subset(2,:)) ;

hold on ;
h = line([x1 ; x2], [y1 ; y2]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(f1(:,subset(1,:))) ;
f2(1,:) = f2(1,:) + size(img1,2) ;
vl_plotframe(f2(:,subset(2,:))) ;
axis image off ;
end

