function [num_matches,matches,dist_vals] = match(image1,image2, distRatio)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Find SIFT keypoints for each image
[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);

matches_ret = 1:1;
dist_vals_ret = 1:1;

for i = 1 : size(des1, 1)
    cur = des1(i);
    distances = zeros(size(des2, 1), 2);
    for j = 1 : size(des2, 1)
        distances(j) = [norm( cur - des2(j) ), j];
    end
    
    distances = sort(distances, 1);
    
    if distances(1, 1) / distances(2, 1) < distRatio
        dist_vals_ret(end + 1) = distances(1);
        matches_ret(end + 1) = [cur des2(distances(1), 2)];
    end
end
dist_vals = dist_vals_ret;
matches = matches_ret;
num_matches = size(matches, 1);
end

