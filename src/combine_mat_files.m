clc
clear
close all

n_features = 100:250:3000;
n_select = [5 10 25 50];
n_boots = 25:25:1000;
method = 'mim';

recalls_array = zeros(numel(n_features),numel(n_boots),numel(n_select));
jaccards_array = zeros(numel(n_features),numel(n_boots),numel(n_select));
lustgarten_array = zeros(numel(n_features),numel(n_boots),numel(n_select));
selection_size_array = zeros(numel(n_features),numel(n_boots),numel(n_select));
errs = 0;

for nf = 1:numel(n_features)
  for ns = 1:numel(n_select)
    for nb = 1:numel(n_boots)
      try 
        disp(['loading ../mat/experiment_scale_bootstraps_',method,'_nf',num2str(n_features(nf)),...
          '_nb',num2str(n_boots(nb)),'_ns',num2str(n_select(ns))]);
        load(['../mat/experiment_scale_bootstraps_',method,'_nf',num2str(n_features(nf)),...
          '_nb',num2str(n_boots(nb)),'_ns',num2str(n_select(ns)),'.mat'], '-regexp',...
          '^|jaccards|^lustgarten|^recalls|^selection_size');
        recalls_array(nf,nb,ns) = recalls;
        jaccards_array(nf,nb,ns) = jaccards;
        lustgarten_array(nf,nb,ns) = lustgarten;
        selection_size_array(nf,nb,ns) = selection_size;
      catch
       errs = errs+1; 
      end
    end
  end
end
save(['../mat/experiment_scale_bootstraps_',method,'.mat']);
disp(' ');
disp(['Saved the combined file in ../mat/experiment_scale_bootstraps_',method,'.mat']);
disp(['There were ',num2str(errs),' errors.'])
