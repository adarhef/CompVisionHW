function [ inliers, M ] = FittingFn( M, x, t )

inliers = [];

n = size(x, 2);

temp = [x(1:2, :)
        ones(1, n)
        x(3:4, :)
        ones(1, n)];
    
for i=1:n
    dist = norm( M * temp(1:3, i) - temp(4:6, i) );
    if (dist < t)
        inliers = [inliers i];
    end
end

end

