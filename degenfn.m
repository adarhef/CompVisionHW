function [ r ] = degenfn( x )

r = 0;

n = size(x, 2);

min = 100000;

for i=1:n
    for j=1:n       
        dist = norm( x(1:2, i) - x(3:4, j) );
        if (i ~= j && dist < min)
            min = dist;
        end
    end
end

if (min < 100)
    r = 1;
end
end

