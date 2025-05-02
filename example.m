
addpath('cifti-matlab/') ; 
addpath('gifti/')

% add data path
addpath('./data/template/')

% add src path
addpath('./src')

% load up the surf helper data
run('./src/init_surfdat.m')

% load up some example data
data = squeeze(niftiread('./data/example/mean.dscalar.nii')) ; 

% this data is for the full greyordinates... but we want just cortex
% the cortex in this data is the first X inds, where X is the sum of valid
% left and right inds
cortexspan = length(surfhelp.lh.inds) + length(surfhelp.rh.inds) ; 
data = data(1:cortexspan) ; 

% plot it
viz_quad_surf(surfhelp,data,parula(100))

% save it! to put it in the readme
set(gcf,"Position",[ 0 0 900 550])
print('./examplesurf.png','-dpng','-r100')
