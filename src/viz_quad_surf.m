function [TLoverall,h] = viz_quad_surf(surfhelp,cortexdata,cmap,clipvals)

if ~exist('cmap','var') || isempty(cmap)
    cmap = parula(100) ; 
end

if ~exist('clipvals','var') || isempty(clipvals)
    clipvals = [ min(cortexdata) max(cortexdata) ] ; 
end

viewangles = [-90 90 90 -90 ] ; 
viewhemis = {'lh' 'rh' 'lh' 'rh'} ; 

TLoverall = tiledlayout(10,10,'TileSpacing','tight') ; 
nt = nexttile(TLoverall) ; 
nt.Visible = "off" ;

TLsurfs = tiledlayout(TLoverall,2,2,'TileSpacing','tight') ; 
TLsurfs.Layout.TileSpan = [10 9] ; 

h = cell(4,1) ; 
for idx = 1:4

    nexttile(TLsurfs) ; 

    % function h = viz_fsLR_surf(surfhelp,data,hemi,viewangle)
    h{idx} = viz_fsLR_surf(surfhelp,cortexdata,viewhemis{idx},viewangles(idx),cmap,clipvals) ;
 
end

nt = nexttile(TLoverall,[2 1]) ; nt.Visible = 'off' ;
nt = nexttile(TLoverall,[6 1 ]); nt.Visible = 'off' ;
cb = colorbar(nt) ;
cb.Location = "east" ; 
cb.AxisLocation = 'out' ; 

colormap(nt,cmap)
clim(double([clipvals(1) clipvals(2)]))
