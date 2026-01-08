function out = faces_2_adj(nverts,faces)

% self loops
out = eye(nverts) ; 

for idx = 1:size(faces,1)
    tri = faces(idx,:) ; 
    % edge 1
    out(tri(1),tri(2)) = 1 ; 
    % edge 2
    out(tri(1),tri(2)) = 1 ;
    % edge 3
    out(tri(2),tri(3)) = 1 ;
end
% transpose
out = out|out' ; 