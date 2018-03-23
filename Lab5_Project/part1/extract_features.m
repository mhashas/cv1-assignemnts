function [keypoints, descriptors] = extract_features(dataset, colorspace, dense, sample_random_image_features, sample_size)

descriptors = [];
keypoints = [];

for i=1:size(dataset, 2)
    
    image = im2single(dataset{i});
    
    switch colorspace
        case 'gray'
            if size(image, 3) > 1
                image = rgb2gray(image);
            end
            
            if dense
                [k, d] = vl_dsift(image, 'step', 10);
            else
                [k, d] = vl_sift(image);
            end
            
        case 'RGB'
            if size(image, 3) == 3
                k = [];
                d = [];
                
                for c=1:size(image, 3)
                    if dense
                        [c_k, c_d] = vl_dsift(image(:,:,c), 'step', 10);
                    else
                        [c_k, c_d] = vl_sift(image(:,:,c));
                    end
                    d = [d, double(c_d)];
                    k = [k, c_k];
                end
                
            else
                warning('RGB called for grayscale');
            end
            
        case 'rgb'
            if size(image, 3) == 3
                k = [];
                d = [];
                image = im2single(rgb2norm(image));
                
                for c=1:size(image, 3)
                    if dense
                        [c_k, c_d] = vl_dsift(image(:,:,c), 'step', 10);
                    else
                        [c_k, c_d] = vl_sift(image(:,:,c));
                    end
                    d = [d, double(c_d)];
                    k = [k, c_k];
                end
                
            else
                warning('rgb called for grayscale');
            end
            
        case 'opponent'
            k = [];
            d = [];
            image = im2single(rgb2opponent(image));
            
            if size(image,3) == 3
                
                for c=1:size(image,3)
                    if dense
                        [c_k, c_d] = vl_dsift(image(:,:,c), 'step', 10);
                    else
                        [c_k, c_d] = vl_sift(image(:,:,c));
                    end
                    d = [d, double(c_d)];
                    k = [k, c_k];
                end
                
            else
                warning('rgb called for grayscale'); 
            end
    end
    
    %sample 200 random descriptors for each image
    if sample_random_image_features
        if sample_size < size(d,2)
            sample_idxs = randsample(size(d,2), sample_size);
            k = k(:, sample_idxs);
            d = d(:, sample_idxs);
        end
    end
    keypoints = [keypoints, k];
    descriptors = [descriptors, d];
end

end