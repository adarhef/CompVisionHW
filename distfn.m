function [ inliers, M ] = distfn( M, x, t )

inliers = [];

n = size(x, 2);

temp = [x(1:2, :)
        ones(1, n)
        x(3:4, :)
        ones(1, n)];
    
for i=1:n
    a = M * temp(1:3, i);
    b = temp(4:6, i);
    dist = norm( a / a(3) - b );
    if (dist < t)
        inliers = [inliers i];
    end
end

end

