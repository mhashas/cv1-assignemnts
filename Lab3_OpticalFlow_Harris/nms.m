function [H] = nms(H, w_size, threshold, top_N)

sorted = sort(H(:),'descend');
threshold = sorted(top_N);

H(H<threshold) = 0;

maxs = ordfilt2(H, w_size*w_size, true(w_size));

H(H~=maxs) = 0;

end

