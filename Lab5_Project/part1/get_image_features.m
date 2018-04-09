function [k, d] = get_image_features(image, colorspace, dense, max_features)

if ~strcmp(colorspace, "gray") && size(image,3) < 3 
    workaround(:,:,1) = image;
    workaround(:,:,2) = image;
    workaround(:,:,3) = image;
    image = workaround;
end

if nargin < 4
    max_features = -1;
end

switch colorspace
    case 'gray'
        if size(image, 3) > 1
            image = rgb2gray(image);
        end
        
        image = im2single(image);
        
        if dense
            [k, d] = vl_dsift(image, 'step', 10);
        else
            [k, d] = vl_sift(image);
        end
        d = double(d);
        
    case 'RGB'
        if size(image, 3) == 3
            k = [];
            d = [];
            image = im2single(image);
            
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

if max_features > 0 && max_features < size(d,2)
    sample_idx = randsample(size(d,2), max_features);
    k = k(:, sample_idx);
    d = d(:, sample_idx);
end