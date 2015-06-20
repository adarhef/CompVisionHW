function [H] = DLT(matches)

    matches1 = matches(:,1:2);
    matches2 = matches(:,3:4);
%     %normalizing
%     matches1_norm = repmat((matches1x.^2 + matches1y.^2).^0.5 , 1 , 2);
%     matches2_norm = repmat((matches2x.^2 + matches2y.^2).^0.5 , 1 , 2);
%     matchesx = [matches1x matches1y]./matches1_norm;
%     matchesy = [matches2x matches2y]./matches2_norm;
%     matches = [matchesx matchesy];
    %translation
    T1_trans = [1 0 -mean(matches1(:,1)); 0 1 -mean(matches1(:,2)); 0 0 1];
    T2_trans = [1 0 -mean(matches2(:,1)); 0 1 -mean(matches2(:,2)); 0 0 1];       
   
    h_matches1 = ([matches1 ones(size(matches1,1),1)])';
    h_matches2 = ([matches2 ones(size(matches2,1),1)])';
    
    h_trans_matches1 = T1_trans*h_matches1;
    h_trans_matches2 = T2_trans*h_matches2;
%     av = mean(matches);
%     av = repmat(av,size(matches,1),1);
%     matches = matches - av;
%     H = matches;

    %scaling
    matches1_norm = (h_trans_matches1(1,:).^2 + h_trans_matches1(2,:).^2).^0.5; 
    matches2_norm = (h_trans_matches2(1,:).^2 + h_trans_matches2(2,:).^2).^0.5;
%    matches1_norm = sqrt(2)*matches1_norm./(sum(matches1_norm)/size(matches1_norm,1));
%    matches2_norm = sqrt(2)*matches2_norm./(sum(matches2_norm)/size(matches2_norm,1));
    
    T1_scale_param = sqrt(2)*size(matches1_norm,2)/sum(matches1_norm);
    T2_scale_param = sqrt(2)*size(matches2_norm,2)/sum(matches2_norm);
    T1_scale = [T1_scale_param 0 0; 0 T1_scale_param 0 ; 0 0 1];
    T2_scale = [T2_scale_param 0 0; 0 T2_scale_param 0 ; 0 0 1];
    
    T1 = T1_scale*T1_trans;
    T2 = T2_scale*T2_trans;
    
   
    
    new_points1 = T1*h_matches1;
    new_points2 = T2*h_matches2;
    
    
    %compute Ai's , new_points2( i , j) is the i'th coordinate in x'j 
    A = [zeros(1,3) -new_points2(3,1)*(new_points1(:,1))' new_points2(2,1)*(new_points1(:,1))' ;
        new_points2(3,1)*(new_points1(:,1))' zeros(1,3) -new_points2(1,1)*(new_points1(:,1))'];
    
    for i=2:size(new_points1,2)
       A_curr = [zeros(1,3) -new_points2(3,i)*(new_points1(:,i))' new_points2(2,i)*(new_points1(:,i))' ;
        new_points2(3,i)*(new_points1(:,i))' zeros(1,3) -new_points2(1,i)*(new_points1(:,i))']; 
       A = [A ; A_curr];
    end
    
    %taking the SVD of A
    [~,~,V] = svd(A);
    h = V(:,size(V,2));
    
    %finding H1 (part 6) 
    H1 = [ h(1)  h(4) h(7) ;
           h(2)  h(5) h(8) ;
           h(3)  h(6) h(9)];
      
    %returning H
   
    H = (T2^-1)*(H1)*(T1);
    H(3,1) = 0;%TODO switch if doesnt help
    H(3,2) = 0;%TODO switch if doesnt help
    H = H/H(3,3);  
end

