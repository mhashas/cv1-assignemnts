function [keypoints, descriptors] = extract_features(dataset, colorspace, dense)

descriptors = [];
keypoints = [];

for i=1:size(dataset)
    image = dataset{i};
    
    switch colorspace
        case 'gray'
            if size(image, 3) > 1
                image = rg2bgray(image);
            end
            
            image = single(image);
            
            if dense
                [k, d] = vl_dsift(image, 'step', 10);
            else
                [k, d] = vl_sift(image);
            end
            
            keypoints = [keypoints, k];
            descriptors = [descriptors, double(d];
                
        case 'RGB'
        if size(image, 3) == 3
            image = single(image);
            k = [];
            d = [];
            if dense
                [k, d] = vl_phow(image, 'Color', 'rgb', 'step', 10);
                d = double(d);
            else
                for c=1:size(image, 3)
                    [c_k, c_d] = vl_sift(image(:,:,c));
                    d = [d, double(c_d)];
                    k = [k, c_k];
                end
            end
            
            keypoints = [keypoints, k];
            descriptors = [descriptors, d];
        else
            warning('RGB called for grayscale');
        end
        
        case 'rgb'
            if size(image, 3) == 3
                k = [];
                d = [];
                image = single(rgb2norm(image));
                
                if dense
                    [k, d] = vl_phow(image, 'Color', 'rgb', 'step', 10);
                    d = double(d);
                else
                    for c=1:size(image, 3)
                        [c_k, c_d] = vl_sift(image(:,:,c));
                        d = [d, double(c_d)];
                        k = [k, c_k];
                    end
                end
                
                keypoints = [keypoints, k];
                descriptors = [descriptors, d];
            else
                warning('rgb called for grayscale');
            end
            
        case 'opponent'
            k = [];
            d = [];
            image = single(rgb2opponent(image));
            if size(image,3) == 3
                if dense
                    [k, d] = vl_phow(image, 'color' , 'opponent', 'step', '10');
                else
                    for c=1:size(image,3)
                        [c_k, c_d] = vl_sift(image(:,:,c));
                        d = [d, double(c_d)];
                        k = [k_, c_k];
                    end
                end
                
                keypoints = [keypoints, k];
                descriptors = [descriptors, d];
            end
    end
end
end