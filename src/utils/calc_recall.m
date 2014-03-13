function r = calc_recall(a, b)
% r = calc_recall(a,b)
%
% Compute the recall of the ground truth in 'a'
%
% By Gregory Ditzler
r = numel(intersection(a,b))/length(a);
