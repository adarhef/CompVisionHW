H = [1 .2 0; .1 1 0; 0.5 0.2 1];

bnw_name = 'scene.pgm';
bnw_projected_name = 'projected_bnw.pgm';

[~, matches, ~] = match(bnw_name, bnw_projected_name, 0.6);
DLT_runs = 5;
error = 0;
for i=1:DLT_runs
    H_DLT = DLT( matches' );
    error = error + ComputeError(H, H_DLT);
end
disp( ['The error of the DLT (averaged over ' num2str(DLT_runs) ' runs):'] );
disp( error / DLT_runs );

warning('off','all');
H_RANSAC = RANSAC_Wrapper(matches', @fittingfn, @distfn, @degenfn, 4, 80, 0, 100000, 100000);

disp( 'The error of RANSAC:');
disp( ComputeError(H, H_RANSAC) );