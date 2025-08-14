function h = viz_fsLR_surf(surfhelp,data,hemi,viewangle,cmap,clipvals)

if ~iscolumn(data)
    if isrow(data)
        data = data(:) ; 
    else
        error('data must be vector plz')
    end
end

% harcode in some fsLR lengths
lens.lh = 29696 ; 
lens.rh = 29716 ; 
lens.fs_LR_hemi = 32492 ; 
lens.lhrh = lens.lh + lens.rh ;

datalen = length(data) ; 

% figure out the hemi
if nargin < 3
    % figure out hemi based on data length
    if datalen == lens.lh
        hemi = 'lh' ;
    elseif datalen == lens.rh
        hemi = 'rh' ;
    elseif datalen == lens.lhrh
        error('need to provide hemi please')
    elseif datalen == lens.fs_LR_hemi
        error('need to provide hemi please')
        % plotinds = 1:lens.fs_LR_hemi ; 
    else
        error('problematic data length provided')
    end
end

% move the inds up potentially, if plotting right side
plotinds = surfhelp.(hemi).inds-surfhelp.(hemi).inds(1)+1 ;

if datalen == lens.lhrh
    if strcmp(hemi,'lh')
        datainds = 1:lens.lh ; 
    else
        datainds = lens.lh+1:lens.lhrh ; 
    end
elseif datalen == lens.fs_LR_hemi
    datainds = plotinds ; 
elseif datalen == lens.fs_LR_hemi*2
    if strcmp(hemi,'lh')
        datainds = plotinds ; 
    else
        datainds = plotinds+lens.fs_LR_hemi ; 
    end
elseif datalen == lens.lh || datalen == lens.rh 
    datainds = 1:length(plotinds) ; 
else
    datainds = surfhelp.(hemi).inds ; 
end
   
% figure out the view
if ~exist('viewangle','var') || isempty(viewangle)
    % if not provide, just default to lateral views of hemi
    if strcmp(hemi,'lh')
        viewangle = [ -90 0 ] ;
    elseif strcmp(hemi,'rh')
        viewangle = [ 90 0 ] ;
    else
        viewangle = [ 0 0 ] ;
    end
end
% fixup any single views by setting second angle to 0
if isscalar(viewangle)
    viewangle = [viewangle 0] ; 
end

if ~exist('cmap','var') || isempty(cmap)
    cmap = parula(100) ; 
end
ncolorbin = size(cmap,1) ; 

getfinite = @(x_) x_(isfinite(x_)) ; 
if ~exist('clipvals','var') || isempty(clipvals)
    clipvals = [ min(getfinite(data(datainds)),[],'omitnan') ...
        max(getfinite(data(datainds)),[],'omitnan') ] ; 
end
if ~isempty(clipvals)
    if ~all(size(clipvals) == [ 1 2 ]) 
        error('clip is wrong size')
    end
end
if ~isfinite(clipvals)
    error('need finite clip vals')
end

%% plot eet

% initialize 
plotdata = nan(size(surfhelp.(hemi).surf.vertices,1),1) ; 

% since the builtin clip function is only in ver matlab versions
% this'll do
clip = @(x_,low,upp) max(min(x_,upp),low) ; 

% potentially clip the data
plotdata(plotinds) = clip(data(datainds),clipvals(1),clipvals(2)) ; 

% grab the non nan data -- there might be nan even in the input data
coloredges = linspace(clipvals(1),clipvals(2)+eps,ncolorbin+1) ; 
colorinds = discretize(plotdata,coloredges) ; 

% make the inds 0
colorinds(isnan(colorinds)) = 0 ;
% and now shift the colormap 'up' 1, to account for 0's
colorinds = colorinds+1 ; 

% plot the surface
hold off
h = patch('faces',surfhelp.(hemi).surf.faces,...
                'vertices', surfhelp.(hemi).surf.vertices, ...
                'facevertexcdata',colorinds,...
                'facecolor','flat', ...
                'edgecolor','none');

% do direct color mapping
h.CDataMapping = "direct" ; 
cmap = [0.5 0.5 0.5 ; cmap ] ; 
colormap(cmap)

% make the surface look cool
view(gca,3)
axis equal
axis off
view(viewangle(1),viewangle(2))
material dull
camlight headlight
lighting gouraud
