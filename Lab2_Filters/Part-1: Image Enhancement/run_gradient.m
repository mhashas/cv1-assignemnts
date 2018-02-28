clear all;
image = imread('./images/image2.jpg');
[Gx, Gy, im_magnitude,im_direction] = compute_gradient(image);
imwrite(Gx, './images/gradient/image2_Gx.jpg');
imwrite(Gy, './images/gradient/image2_Gy.jpg');
imwrite(im_magnitude, './images/gradient/image2_magnitude.jpg');
imwrite(im_direction, './images/gradient/image2_direction.jpg');


imwrite(compute_LoG(image, 1),'./images/gradient/image2_log1.jpg')
imwrite(compute_LoG(image, 2),'./images/gradient/image2_log2.jpg')
sigmas = [0.125 0.5 2 8 32 128 512 1024];
for s1 = sigmas
    for s2 = sigmas
        imwrite(compute_LoG(image, 3,[s1, s2]),strcat('./images/gradient/image2_log3_s1=',num2str(s1),'_s2=',num2str(s2),'.jpg'));
    end
end