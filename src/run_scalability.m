% Test the scalability of NPFS on a synthetic data set with an increasing 
% dimensionality of the feature set. The number of relevant features 
% remains fixed for the experiment. Thus the solution of the subset selection
% problem becomes increasingly more sparse when you compare the number of
% relevant features to the total number of features. 
%
% By: Gregory Ditzler (3/13/2014)
clc;
clear;
close all;

% i have the feast library in a private path. you can download the toolbox
% from adam pocock's github page or from mloss
addpath('utils/');
addpath(genpath('~/Git/thesis-code/feat_sel/FEAST/'));

n_relevant = 10;
n_features = [50,100:50:500,750,1000,2000];
n_boots = [100,250];
n_select = [5,10,25,50];
n_samples = 5000;
method = 'mim';
alpha = 0.01;
avg = 20;

matlabpool close force
matlabpool open local 12

recalls = zeros(numel(n_features),numel(n_boots),numel(n_select));
jaccards = zeros(numel(n_features),numel(n_boots),numel(n_select));
lustgarten = zeros(numel(n_features),numel(n_boots),numel(n_select));
selection_size = zeros(numel(n_features),numel(n_boots),numel(n_select));


for a = 1:avg
  for nf = 1:numel(n_features)
    for nb = 1:numel(n_boots)
      for ns = 1:numel(n_select)
        disp(['NF:',num2str(n_features(nf)),', NB:',num2str(n_boots(nb)),...
          ', NS:',num2str(n_select(ns))]);
        [data,labels] = uni_data(n_samples, n_features(nf), n_relevant, 'hard');
        idx = npfs(data, labels, method, n_select(ns), n_boots(nb), alpha, 0);
        selection_size(nf,nb,ns) = numel(idx);
        recalls(nf,nb,ns) = recalls(nf,nb,ns) + calc_recall(1:n_relevant, idx);
        jaccards(nf,nb,ns) = jaccards(nf,nb,ns) + calc_jaccard(1:n_relevant, idx);
        lustgarten(nf,nb,ns) = lustgarten(nf,nb,ns) + calc_lustgarten(1:n_relevant, ...
          idx, n_features(nf));
      end
    end
  end
end
recalls = recalls/avg;
jaccards = jaccards/avg;
lustgarten = lustgarten/avg;

matlabpool close force;
save(['../mat/experiment_scalability_',method,'.mat']);
