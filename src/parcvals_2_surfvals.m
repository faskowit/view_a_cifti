function outsurfdat = parcvals_2_surfvals(parcinds,parcvals)
outsurfdat = nan(length(parcinds),1) ; 
for idx = 1:length(parcvals)
    outsurfdat(parcinds==idx) = parcvals(idx) ; 
end