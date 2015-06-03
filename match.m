function [num_matches,matches,dist_vals] = match(image1,image2, distRatio)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Find SIFT keypoints for each image
[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);

matches_ret = [];
dist_vals_ret = [];
pointsInIm1 = [;];
pointsInIm2 = [;];

for i = 1 : size(des1, 1)
    cur = des1(i, :);
    distances = zeros(size(des2, 1), 1);
    min = flintmax;
    minIndex = 1;
    for j = 1 : size(des2, 1)
        distances(j) = norm( cur - des2(j, :) );
        if (distances(j) < min)
            minIndex = j;
            min = distances(j);
        end
    end
    
    distances = sort(distances, 1);
    
    if distances(1, 1) / distances(2, 1) < distRatio
        dist_vals_ret = [dist_vals_ret; distances(1, 1) / distances(2, 1)];
        pointsInIm1 = [pointsInIm1; loc1(i, 1:2)];
        pointsInIm2 = [pointsInIm2; loc2(j, 1:2)];
    end
end
dist_vals = dist_vals_ret;
matches = horzcat(pointsInIm1, pointsInIm2, dist_vals_ret);
num_matches = size(matches, 1);
end

