function [ noisedMatches ] = gaussianNoise( matches, width )

% assumes matches is n x 5. Returns noise with standard normal distribution
n = size( matches, 1 );
noise = width * [randn(n, 4) zeros(n, 1)];

noisedMatches = noise + matches;
end