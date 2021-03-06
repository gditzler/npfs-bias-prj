function condor_run_scale_bootstraps(rs,n_features,n_boots,n_select)
% This is pretty much the same script as the run_scalability.m; however
% this script runs many more values for the bootstraps and the feature
% dimensionality. 
rng(rs)
addpath('/home/gcd34/Git/npfs-bias-prj/src/utils/');
addpath(genpath('/home/gcd34/Git/thesis-code/feat_sel/FEAST/'));

n_relevant = 10;
n_samples = 5000;
method = 'mim';
alpha = 0.01;
avg = 15;

recalls = 0;
jaccards = 0;
lustgarten = 0;
selection_size = 0;

bias_term = n_select/n_features;
if bias_term>1
  bias_term = 0;
end

for a = 1:avg
  [data,labels] = uni_data(n_samples, n_features, n_relevant, 'hard');
  idx = npfs(data, labels, method, n_select, n_boots, alpha, bias_term);
  selection_size = selection_size+numel(idx);
  recalls = recalls + calc_recall(1:n_relevant, idx);
  jaccards = jaccards + calc_jaccard(1:n_relevant, idx);
  lustgarten = lustgarten + calc_lustgarten(1:n_relevant, idx, n_features);
end
recalls = recalls/avg;
jaccards = jaccards/avg;
lustgarten = lustgarten/avg;
selection_size = selection_size/avg;

save(['/home/gcd34/Git/npfs-bias-prj/mat/single_',method,'/experiment_scale_bootstraps_',method,'_nf',...
  num2str(n_features),'_nb',num2str(n_boots),'_ns',num2str(n_select),'.mat']);
