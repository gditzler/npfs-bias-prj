clc;
clear;
close all;

addpath('utils/');

n_relevant = 10;
n_features = [50,100:50:500,750,1000,2000];
n_boots = [100,250];
n_select = [5,10,25,50];
n_samples = 1000;
method = 'mim';
alpha = 0.01;

matlabpool close force
matlabpool open local 12


for nf = 1:numel(n_features)
  for nb = 1:numel(n_boots)
    for ns = 1:numel(n_select)
      [data,labels] = uni_data(n_samples, n_features(nf), n_relevant, 'hard');
      idx = npfs(data, labels, method, n_select, n_boots(nb), alpha, 0);
      recalls(nf,nb,ns) = calc_recall(1:n_relevant, idx);
      jaccards(nf,nb,ns) = calc_jaccard(1:n_relevant, idx);
      lustgarten(nf,nb,ns) = calc_lustgarten(1:n_relevant, idx);
    end
  end
end
save('../mat/experiment_scalability.mat');
