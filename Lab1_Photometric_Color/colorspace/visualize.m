function visualize(input_image)  
sizes = size(input_image);
D = sizes(3);
if D == 3
    f = subplot(2,2,1); imshow(input_image)
    title('result')
    subplot(2,2,2); imshow(input_image(:,:,1))
    title('channel 1')
    subplot(2,2,3); imshow(input_image(:,:,2))
    title('channel 2')
    subplot(2,2,4); imshow(input_image(:,:,3))
    title('channel 3')
else
    f = subplot(2,2,1); imshow(input_image(:,:,1))
    title('matlab grey')
    subplot(2,2,2); imshow(input_image(:,:,2))
    title('grey lightness')
    subplot(2,2,3); imshow(input_image(:,:,3))
    title('grey average')
    subplot(2,2,4); imshow(input_image(:,:,4))
    title('grey luminosity')
end
waitfor(f)

end


