% This script plots the prediction results for remaining graphs done in
% 'prediction'.

clc;
clear all;

%% Plot kNN results for tree graphs, linear regression
fileID=fopen('TreeExisting_pca.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

fileID=fopen('TreeNonExisting_pca_1.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_nonexisting=[lines_pca{2} lines_pca{3}];
Class_nonexisting=[lines_pca{4}];

fileID=fopen('TreeRemaining_pca_labels_k9_1.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_rem=[lines_pca{2} lines_pca{3}];
Class_rem=[lines_pca{4}];

Params=[Params_existing;Params_nonexisting;Params_rem];
Class=[Class_existing;Class_nonexisting;Class_rem];

figure(1);
set(gcf,'color','w');
colors = [0 0 1; 0 0 0];
hold on;
gscatter(Params(:,1),Params(:,2),Class,colors,'.',[20;20]);
scatter(Params_existing(:,1),Params_existing(:,2),'r','filled');
scatter(Params_nonexisting(:,1),Params_nonexisting(:,2),'y','filled');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
set(gcf,'color','w');
title('Tree KNN Linear with 9 Neighbors', 'FontSize', 60);
legend('RNA-like','Non RNA-like','Existing','Negative Data', 'FontSize', 30);
hold off;

%% Plot kNN results for tree graphs, polynomial regression
fileID=fopen('TreeExisting_pca_poly.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

fileID=fopen('TreeNonExisting_pca_poly_1.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_nonexisting=[lines_pca{2} lines_pca{3}];
Class_nonexisting=[lines_pca{4}];

fileID=fopen('TreeRemaining_pca_labels_poly_k9_1.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_rem=[lines_pca{2} lines_pca{3}];
Class_rem=[lines_pca{4}];

Params=[Params_existing;Params_nonexisting;Params_rem];
Class=[Class_existing;Class_nonexisting;Class_rem];

figure(2);
set(gcf,'color','w');
colors = [0 0 1; 0 0 0];
hold on;
gscatter(Params(:,1),Params(:,2),Class,colors,'.',[20;20]);
scatter(Params_existing(:,1),Params_existing(:,2),'r','filled');
scatter(Params_nonexisting(:,1),Params_nonexisting(:,2),'y','filled');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
set(gcf,'color','w');
title('Tree KNN Quadratic with 9 Neighbors', 'FontSize', 60);
legend('RNA-like','Non RNA-like','Existing','Negative Data', 'FontSize', 30);
hold off;

%% Plot kNN results for dual graphs, linear regression
fileID=fopen('DualExisting_pca.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

fileID=fopen('DualNonExisting_pca_1.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_nonexisting=[lines_pca{2} lines_pca{3}];
Class_nonexisting=[lines_pca{4}];

fileID=fopen('DualRemaining_pca_labels_k19_1.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_rem=[lines_pca{2} lines_pca{3}];
Class_rem=[lines_pca{4}];

Params=[Params_existing;Params_nonexisting;Params_rem];
Class=[Class_existing;Class_nonexisting;Class_rem];

figure(3);
set(gcf,'color','w');
colors = [0 0 1; 0 0 0];
hold on;
gscatter(Params(:,1),Params(:,2),Class,colors,'.',[20;20]);
scatter(Params_existing(:,1),Params_existing(:,2),'r','filled');
scatter(Params_nonexisting(:,1),Params_nonexisting(:,2),'y','filled');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
set(gcf,'color','w');
title('Dual KNN Linear with 19 Neighbors', 'FontSize', 60);
legend('RNA-like','Non RNA-like','Existing','Negative Data', 'FontSize', 30);
hold off;

%% Plot kNN results for dual graphs, linear regression
fileID=fopen('DualExisting_pca_poly.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

fileID=fopen('DualNonExisting_pca_poly_1.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_nonexisting=[lines_pca{2} lines_pca{3}];
Class_nonexisting=[lines_pca{4}];

fileID=fopen('DualRemaining_pca_labels_poly_k19_1.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_rem=[lines_pca{2} lines_pca{3}];
Class_rem=[lines_pca{4}];

Params=[Params_existing;Params_nonexisting;Params_rem];
Class=[Class_existing;Class_nonexisting;Class_rem];

figure(4);
set(gcf,'color','w');
colors = [0 0 1; 0 0 0];
hold on;
gscatter(Params(:,1),Params(:,2),Class,colors,'.',[20;20]);
scatter(Params_existing(:,1),Params_existing(:,2),'r','filled');
scatter(Params_nonexisting(:,1),Params_nonexisting(:,2),'y','filled');
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
set(gcf,'color','w');
title('Dual KNN Quadratic with 19 Neighbors', 'FontSize', 60);
legend('RNA-like','Non RNA-like','Existing','Negative Data', 'FontSize', 30);
hold off;


