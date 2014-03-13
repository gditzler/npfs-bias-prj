function j = calc_jaccard(a, b)
% j = calc_jaccard(a,b)
% 
% Calculate the Jaccard stability index
%
% By: Gregory Ditzler
j = numel(intersect(a,b))/numel(union(a,b));
