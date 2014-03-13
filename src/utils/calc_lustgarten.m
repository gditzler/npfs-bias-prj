function l = calc_lustgarten(a,b,k)
% l = calc_lustgarten(a,b,k)
% 
% Calculate the Lustgarten et al stability index
%
% By: Gregory Ditzler 
al = numel(a);
bl = numel(b);
r = numel(intersect(a,b));
l = (r-al*bl/k)/(min(al,bl)-max(0,al+bl-k));
