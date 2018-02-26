clear all;
images = ["./images/image1_gaussian.jpg", "./images/image1_saltpepper.jpg"];
filters = ["box", "median", "gaussian"];
params = { {{"size",[3,5,7]}}, {{"size",[3,5,7]}}, {{"sigma",[0.5,1,2]}, {"kernel_size",[3,5,7]}}};
distances = {};
for idx_img = 1:length(images)
    source_path = images(idx_img);
    for idx_filter = 1:length(filters)
        filter = filters(idx_filter);
        params_filter = params{idx_filter};
        img_name = strsplit(source_path,"/");
        img_name = img_name(3);
        img_name = strsplit(img_name,".");
        img_name = img_name(1);
        
        if length(params_filter) == 1
            params_filter = params_filter{1};
            param_names = [params_filter{1}];
            param_values = [params_filter{2}];
            
        elseif length(params_filter) == 2
            [X,Y] = meshgrid(params_filter{1}{2},params_filter{2}{2});
            result = [X(:)'; Y(:)'];
            
            param_names = [params_filter{1}{1}, params_filter{2}{1}];
            param_values = result;
        end
        
        [~, nr_params] = size(param_values);
        for param_idx = 1:nr_params
            params_values = param_values(:, param_idx)';
            
            params_str = "";
            for name_constr_idx = 1:length(params_values)
                params_str = strcat(params_str,"_",param_names(name_constr_idx),"=",num2str(params_values(name_constr_idx)));
            end
            dest_name = strcat("./images/denoise/", img_name, "_noise_", filter, "-filter", params_str, ".jpg");
            
            imwrite(denoise(imread(source_path{1}),filter, params_values), dest_name{1});
            
            distance = myPSNR(imread(dest_name{1}), imread('./images/image1.jpg'));
            distances{length(distances)+1} = { dest_name, distance };
        end
        
    end
    write_distances('./images/denoise/distances.txt', distances)
end