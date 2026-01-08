function bords = get_bords(parcvals,neicell) ; 
uniqnonan = @(x_) unique(x_(~isnan(x_))) ; 
bords = cellfun(@(x_) length(uniqnonan(parcvals(x_)))>1,neicell) ; 