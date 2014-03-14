clc
clear
close all

load ../mat/experiment_scalability_mim.mat

c = {'k-^','b-*','r-p','c-s','g-o','co','k--'};
fs = 26;
boot_idx = 2;

figure;
hold on;
box on;
for i = 1:size(recalls,3)
  plot(n_features, jaccards(:,boot_idx,i), c{i}, 'LineWidth',2)
end
legend('k=5','k=10','k=25','k=50','Location','best')
xlabel('# of features','FontSize',fs)
ylabel('Jaccard Index','FontSize',fs)
set(gca,'fontsize',fs)

figure;
hold on;
box on;
for i = 1:size(recalls,3)
  plot(n_features, lustgarten(:,boot_idx,i), c{i}, 'LineWidth',2)
end
legend('k=5','k=10','k=25','k=50','Location','best')
xlabel('# of features','FontSize',fs)
ylabel('Lustgarten Index','FontSize',fs)
set(gca,'fontsize',fs)

figure;
hold on;
box on;
for i = 1:size(recalls,3)
  plot(n_features, recalls(:,boot_idx,i), c{i}, 'LineWidth',2)
end
legend('k=5','k=10','k=25','k=50','Location','best')
xlabel('# of features','FontSize',fs)
ylabel('Recall','FontSize',fs)
set(gca,'fontsize',fs)

figure;
hold on;
box on;
for i = 1:size(recalls,3)
  plot(n_features, selection_size(:,boot_idx,i), c{i}, 'LineWidth',2)
end
legend('k=5','k=10','k=25','k=50','Location','best')
xlabel('# of features','FontSize',fs)
ylabel('Recall','FontSize',fs)
set(gca,'fontsize',fs)