% lets setup reading some surfaces

surfhelp = struct() ; 
greyord = cifti_read('91282_Greyordinates.dscalar.nii') ; 

surfhelp.lh.inds = greyord.diminfo{1}.models{1}.start+greyord.diminfo{1}.models{1}.vertlist ; 
surfhelp.rh.inds = (greyord.diminfo{1}.models{1}.numvert+1)+greyord.diminfo{1}.models{2}.vertlist ; 

surfhelp.lh.surf = gifti(which('fs_LR.32k.L.inflated.surf.gii')) ; 
surfhelp.rh.surf = gifti(which('fs_LR.32k.R.inflated.surf.gii')) ; 

cortexverts = greyord.diminfo{1}.models{1}.numvert + greyord.diminfo{1}.models{2}.numvert ; 
surfhelp.midline = ismember(1:cortexverts,[ surfhelp.lh.inds surfhelp.rh.inds ] )==0 ; 
surfhelp.cortex = ~surfhelp.midline ; 
clear cortexverts

surfhelp.lh.span = greyord.diminfo{1}.models{1}.start:greyord.diminfo{1}.models{1}.numvert ; 
surfhelp.rh.span = (greyord.diminfo{1}.models{1}.numvert+1):(greyord.diminfo{1}.models{1}.numvert)+greyord.diminfo{1}.models{2}.numvert ; 

%%

ciftihelp = struct() ; 
ciftihelp.lh.inds = greyord.diminfo{1}.models{1}.start:greyord.diminfo{1}.models{1}.start+greyord.diminfo{1}.models{1}.count-1 ; 
ciftihelp.rh.inds = greyord.diminfo{1}.models{2}.start:greyord.diminfo{1}.models{2}.start+greyord.diminfo{1}.models{2}.count-1 ; 

% lets loop through all the models
% oo = 0 ; 
for idx = 1:length(greyord.diminfo{1}.models)
    nn = greyord.diminfo{1}.models{idx}.struct ;
    ss = greyord.diminfo{1}.models{idx}.start ; 
    cc = greyord.diminfo{1}.models{idx}.count ; 
    ciftihelp.modelind.(nn) = ss:ss+cc-1 ; 
    % oo = oo + length(ciftihelp.modelind.(nn)) ; 
end
% oo sanity check good
clear nn ss cc
