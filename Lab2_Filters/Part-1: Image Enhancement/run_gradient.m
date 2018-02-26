clear all;
[Gx, Gy, im_magnitude,im_direction] = compute_gradient(imread('./images/image2.jpg'));
imwrite(Gx, './images/gradient/image2_Gx.jpg');
imwrite(Gy, './images/gradient/image2_Gy.jpg');
imwrite(im_magnitude, './images/gradient/image2_magnitude.jpg');
imwrite(im_direction, './images/gradient/image2_direction.jpg');