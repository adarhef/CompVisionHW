function [ pnts_gt, pnts_computed ] = ComputeTestPoints( H_gt, H_computed)

src_pts = [5 * randn(2, 120)
           ones( 1, 120 )];
for i=1:120
    src_pts(1:2, i) = src_pts(1:2, i) / norm(src_pts(1:2, i));
end

pnts_gt = H_gt * src_pts;
pnts_computed = H_computed * src_pts;

end