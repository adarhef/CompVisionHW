function [ H ] = DLT( matches )

n = size( matches, 2 );

% Convert to homogenous coordinates

temp = zeros( 6, n );
for i=1:n
    temp(:, i) = [matches(1:2, i)
                  1 
                  matches(3:4, i) 
                  1];
end
matches = temp;

% At this point matches is an N by 4 matrix, in which the first two columns
% are points from the first image and the 3rd and 4th columns are their
% matches in the 2nd image.
TtranslateXi = getTranslateByMeanMatrix( matches(1:3, :) );
TscaleXi = getScaleToAvgMatrix( TtranslateXi * matches(1:3, :), sqrt(2) );
T = TscaleXi * TtranslateXi;

TtranslateXiTag = getTranslateByMeanMatrix( matches(4:6, :) );
TscaleXiTag = getScaleToAvgMatrix( TtranslateXiTag * matches(4:6, :), sqrt(2) );
T_Tag = TscaleXiTag * TtranslateXiTag;


A = zeros(2*n, 9);

for i=1:n
    xi = T * matches(1:3, i);
    xitag = T_Tag * matches(4:6, i);
    
    A(2*i - 1, :) = [0 0 0 -xitag(3)*xi' xitag(2)*xi'];
    A(2*i, :) = [xi'*xitag(3) 0 0 0 -xitag(1)*xi'];
end

% Obtain A's SVD
[~, ~, V] = svd(A);

h = V(:, size(V, 2)); 

H = inv(T_Tag) * horzcat(h(1:3), h(4:6), h(7:9)) * T;
H = H/H(3,3);

H(3,1) = 0;
H(3,2) = 0;

H = H';
end

function [ translateMatrix ] = getTranslateByMeanMatrix( points )
pointsMean = mean( points, 2 );
n = size( points, 2);
translateMatrix = [1 0 -pointsMean(1)
                   0 1 -pointsMean(2)
                   0 0 1];           
end

function [ scaleMatrix ] = getScaleToAvgMatrix( points, avgLength )
n = size( points, 2 );
sum = 0;

for i=1:n
    sum = sum + norm( points(:, i) );
end

multiplier = n * avgLength / sum;

scaleMatrix = [multiplier 0 0; 0 multiplier 0; 0 0 1;];

end