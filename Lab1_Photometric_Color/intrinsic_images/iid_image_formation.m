function reconstructed_image = iid_image_formation(reflectance, shading)
reconstructed_image = im2double(reflectance) .* im2double(shading); % I = R x S
end