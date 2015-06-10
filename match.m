function [num_matches,matches,dist_vals] = match(image1,image2, distRatio)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Find SIFT keypoints for each image
[~, des1, loc1] = sift(image1);
[~, des2, loc2] = sift(image2);

dist_vals_ret = [];
pointsInIm1 = [;];
pointsInIm2 = [;];

des2t = des2';                          % Precompute matrix transpose
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [distances, index] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (distances(1) < distRatio * distances(2))
      dist_vals_ret = [dist_vals_ret; distances(1)];
      pointsInIm1 = [pointsInIm1; fliplr(loc1(i, 1:2))];
      pointsInIm2 = [pointsInIm2; fliplr(loc2(index(1), 1:2))];
   end
end

dist_vals = dist_vals_ret;
matches = horzcat(pointsInIm1, pointsInIm2, dist_vals_ret);
num_matches = size(matches, 1);
end

