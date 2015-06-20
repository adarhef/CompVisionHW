function [ error ] = ComputeError( H_gt, H_computed )

[ pnts_gt, pnts_computed ] = ComputeTestPoints( H_gt,H_computed);

n = size( pnts_gt, 1 );

error = 0;

for i=1:n
    error = error + norm( pnts_gt(1:2, i) - pnts_computed(1:2, i) );
end

end