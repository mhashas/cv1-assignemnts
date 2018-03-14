function [f1, f2, scores, matches, d1, d2] = keypoint_matching(im1, im2)

im1_single = single(im1);
im2_single = single(im2);

% vl_sift computes the SIFT frames (keypoints) and descriptors
[f1, d1] = vl_sift(im1_single);
[f2, d2] = vl_sift(im2_single);

% frames are matches and given a score sing the descriptors
[matches, scores] = vl_ubcmatch(d1, d2);

end