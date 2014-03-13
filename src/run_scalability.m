clc;
clear;
close all;

addpath('utils/');
addpath(genpath('~/Git/thesis-code/feat_sel/FEAST/'));

n_relevant = 10;
n_features = [50,100:50:500,750,1000,2000];
n_boots = [100,250];
n_select = [5,10,25,50];
n_samples = 1000;
method = 'mim';
alpha = 0.01;

matlabpool close force
matlabpool open local 12

recalls = zeros(numel(n_features),numel(n_boots),numel(n_select));
jaccards = zeros(numel(n_features),numel(n_boots),numel(n_select));
lustgarten = zeros(numel(n_features),numel(n_boots),numel(n_select));

for nf = 1:numel(n_features)
  for nb = 1:numel(n_boots)
    for ns = 1:numel(n_select)
      disp(['NF:',num2str(n_features(nf)),', NB:',num2str(n_boots(nb)),...
        ', NS:',num2str(n_select(ns))]);
      [data,labels] = uni_data(n_samples, n_features(nf), n_relevant, 'hard');
      idx = npfs(data, labels, method, n_select(ns), n_boots(nb), alpha, 0);
      recalls(nf,nb,ns) = calc_recall(1:n_relevant, idx);
      jaccards(nf,nb,ns) = calc_jaccard(1:n_relevant, idx);
      lustgarten(nf,nb,ns) = calc_lustgarten(1:n_relevant, idx, n_features(nf));
    end
  end
end
matlabpool close force;
save('../mat/experiment_scalability.mat');
