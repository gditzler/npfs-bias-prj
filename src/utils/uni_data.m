function [data,labels] = uni_data(n_samples, n_features, n_relevent, type)
% [data,labels] = uni_data(n_samples, n_features, n_relevent)
% 
%   @n_samples - number on data points
%   @n_features - total number of features
%   @n_relevent - number of relevant features (< @n_features)
%   @data
%   @labels
% 
%   Generate a data set which has feature uniformly distributed. There 
%   are only @n_relevent features in the data set that carry information
%   about the class label. 
%   
%  Written by: Gregory Ditzler (gregory.ditzler@gmail.com)  
data = round(10 * rand(n_samples, n_features));
T = 5 * n_relevent;
labels = zeros(n_samples, 1);

if strcmp(type, 'hard')
  % features are either relevant or irrelevant
  labels(sum(data(:,1:n_relevent),2) > T) = 2;
  labels(labels == 0) = 1;
elseif strcmp(type, 'linear')
  % relevancy is a linear function
  w = repmat(linspace(1, 0, n_features), n_samples, 1);
  w = sum(w.*data,2);
  T = mean(w);
  labels(w > T) = 2;
  labels(labels == 0) = 1;
else strcmp(type, 'logsig')
  % relevancy is a sigmoid function
  lim = 6;
  w = 1 - logsig(linspace(-lim, lim, n_features));
  w = repmat(w, n_samples, 1);
  z = sum(w.*data,2);
  labels(z > mean(z)) = 1;
  labels(labels == 0) = 2;
end
