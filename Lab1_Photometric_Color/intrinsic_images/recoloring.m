function recolored_image = recoloring(reflectance, shading, R, G, B)

recolored = zeros(size(reflectance));

recolored(:,:,1) = R;
recolored(:,:,2) = G;
recolored(:,:,3) = B;

recolored_image = iid_image_formation(im2double(recolored), shading);
end
