function [ noisedMatches ] = uniformNoise( matches, width )

% assumes matches is n x 5. Returns noise with standard normal distribution
n = size( matches, 1 );
noise = width* (rand(n, 4) -0.5);

noisedMatches = [noise zeros(n, 1)] + matches;
end