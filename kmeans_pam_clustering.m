% This script performs Kmeans/PAM clustering for both linear and polynomial
% fits, only PCA data used, as results for PCA and MDS same

clc;
clear all;

%% PCA Linear fit Kmeans PAM
% reading pca files
fileID=fopen('DualGraphParams_pca.txt','r'); %change to read whatever parameters you want
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);
GraphIDs=string(lines_pca{1});
Params = [lines_pca{2} lines_pca{3}];

fileID=fopen('DualExisting_pca.txt','r'); % change to read whatever parameters you want
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);
existingIDs=string(lines_pca{1});
existingParams = [lines_pca{2} lines_pca{3}];

% K-means clustering on the data
[idx,C] = kmeans(Params, 2);
IdNo = load('DualExistingIdNo.txt'); % change this according to what you want to classify
count = 0;
N = length(IdNo);
for i = 1:N
    if (idx(IdNo(i))==1)
        count = count+1;
    end
end
if count < N-count % RNA like points are indexed 1
    idx(idx==2)=3;
    idx(idx==1)=2;
    idx(idx==3)=1;
end

p_Kmeans_lin = sum(idx(:) == 1)/length(idx); % percentage of RNA like
q_Kmeans_lin = sum(idx(:) == 2)/length(idx); % percentage of nonRNA like
c_Kmeans_lin = max(count/N, 1-count/N); % percentage of existing RNAs classified into RNA like

colors = [0 0 1; 0 0 0];
figure(1);
set(gcf,'color','w');
hold on;
gscatter(Params(:,1),Params(:,2),idx,colors,'.',[20;20]);
scatter(existingParams(:,1),existingParams(:,2),'r','filled');
scatter(C(:,1), C(:,2), 100, 'g', 'd', 'filled');
title('Dual Kmeans Linear Regression', 'FontSize', 60); % change this according to what you want to classify
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
legend('RNA Like', 'nonRNA Like', 'Existing', 'Centroids', 'FontSize', 30);
hold off;


% K-medoids clustering on the data - by default it is PAM
[idx,C] = kmedoids(Params,2);
count = 0;
N = length(IdNo);
for i = 1:N
    if (idx(IdNo(i))==1)
        count = count+1;
    end
end
if count < N-count % RNA like points are indexed 1
    idx(idx==2)=3;
    idx(idx==1)=2;
    idx(idx==3)=1;
end

p_PAM_lin = sum(idx(:) == 1)/length(idx);
q_PAM_lin = sum(idx(:) == 2)/length(idx);
c_PAM_lin = max(count/N, 1-count/N);

figure(2);
set(gcf,'color','w');
hold on;
gscatter(Params(:,1),Params(:,2),idx,colors,'.',[20;20]);
scatter(existingParams(:,1),existingParams(:,2),'r','filled');
scatter(C(:,1), C(:,2), 100, 'g', 'd', 'filled');
title('Dual PAM Linear Regression', 'FontSize', 60); % change this according to what you want to classify
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
legend('RNA Like', 'nonRNA Like', 'Existing', 'Medoids', 'FontSize', 30);
hold off;

%% PCA Polynomial fit Kmeans PAM
fileID=fopen('DualGraphParams_pca_poly.txt','r'); %change to read whatever parameters you want
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);
GraphIDs=string(lines_pca{1});
Params = [lines_pca{2} lines_pca{3}];

fileID=fopen('DualExisting_pca_poly.txt','r'); %change to read whatever parameters you want
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);
existingIDs=string(lines_pca{1});
existingParams = [lines_pca{2} lines_pca{3}];

% K-means clustering on the data
[idx,C] = kmeans(Params, 2);
IdNo = load('DualExistingIdNo.txt'); % change this according to what you want to classify
count = 0;
N = length(IdNo);
for i = 1:N
    if (idx(IdNo(i))==1)
        count = count+1;
    end
end
if count < N-count % RNA like points are indexed 1
    idx(idx==2)=3;
    idx(idx==1)=2;
    idx(idx==3)=1;
end

p_Kmeans_poly = sum(idx(:) == 1)/length(idx);
q_Kmeans_poly = sum(idx(:) == 2)/length(idx);
c_Kmeans_poly = max(count/N, 1-count/N);

colors = [0 0 1; 0 0 0];
figure(3);
set(gcf,'color','w');
hold on;
gscatter(Params(:,1),Params(:,2),idx,colors,'.',[20;20]);
scatter(existingParams(:,1),existingParams(:,2),'r','filled');
scatter(C(:,1), C(:,2), 100, 'g', 'd', 'filled');
title('Dual Kmeans Quadratic Regression', 'FontSize', 60); % change this according to what you want to classify
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
legend('RNA Like', 'nonRNA Like', 'Existing', 'Centroids', 'FontSize', 30);
hold off;

% K-medoids clustering on the data - by default it is PAM
[idx,C] = kmedoids(Params,2);
count = 0;
N = length(IdNo);
for i = 1:N
    if (idx(IdNo(i))==1)
        count = count+1;
    end
end
if count < N-count % RNA like points are indexed 1
    idx(idx==2)=3;
    idx(idx==1)=2;
    idx(idx==3)=1;
end

p_PAM_poly = sum(idx(:) == 1)/length(idx);
q_PAM_poly = sum(idx(:) == 2)/length(idx);
c_PAM_poly = max(count/N, 1-count/N);

figure(4);
set(gcf,'color','w');
hold on;
gscatter(Params(:,1),Params(:,2),idx,colors,'.',[20;20]);
scatter(existingParams(:,1),existingParams(:,2),'r','filled');
scatter(C(:,1), C(:,2), 100, 'g', 'd', 'filled');
title('Dual PAM Quadratic Regression', 'FontSize', 60); % change this according to what you want to classify
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
legend('RNA Like', 'nonRNA Like', 'Existing', 'Medoids', 'FontSize', 30);
hold off;

% output the accuracy and graph distribution data to latex table
results = [p_Kmeans_lin, p_PAM_lin, p_Kmeans_poly, p_PAM_poly; q_Kmeans_lin, q_PAM_lin, q_Kmeans_poly, q_PAM_poly; c_Kmeans_lin, c_PAM_lin, c_Kmeans_poly, c_PAM_poly];
input.data = results;
input.tableColLabels = {'Kmeans Linear', 'PAM Linear', 'Kmeans Poly', 'PAM Poly'};
input.tableRowLabels = {'RNA Like percent', 'nonRNA Like percent', 'Correct percent'};
latex = latexTable(input);
