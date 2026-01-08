function neicell = get_nei(nverts,faces)
mat = faces_2_adj(nverts, faces) ;
mat(1:(nverts+1):end) = 0 ; % zero out diagonal
neicell = arrayfun(@(i_) find(mat(:,i_)) , 1:size(mat,1) , 'UniformOutput' , false) ; 