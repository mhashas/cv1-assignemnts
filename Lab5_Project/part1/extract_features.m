function [features] = extract_features(dataset, colorspace, dense)
features = [];

for i=1:size(dataset)
    image = dataset{i};
    
    switch colorspace
        case 'gray'
            if size(image, 3) > 1
                image = rg2bgray(image);
            end
            
            image = single(image);
            
            if dense
                [~, d] = vl_dsift(image);
            else 
                [~, d] = vl_sift(image);
            end
            
            features = [features, double(d)];
            
        case 'RGB'
            if size(image, 3) == 3
                image = single(image);
                if dense
                    [~, d] = vl_phow(image, 'Color', 'rgb');
                    d = double(d);
                else 
                    for c=1:size(image, 3)
                        [~, c_d] = vl_sift(image(:,:,c));
                        d = [d, double(c_d)];
                    end
                end
            
                features = [features, d];
            end
            
           
               
                    
            
    end
end
end