% This script performs kNN clustering for both linear and polynomial fits.
% Go over the 10 negative samples sets to find mean/min/max of accuracy
% using 10 fold cross validation.
% Number of neighbors ranging from 1 to 19, with only odd numbers
% considered.

clc;
clear all;

%% KNN Linear fit
fileID=fopen('DualExisting_pca.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

Loss_percentage=zeros(10,10);

for trial = 1:10 % go over the 10 negative traning sample sets
    
    file=sprintf('DualNonExisting_pca_%d.txt',trial); % change this according to what you want to classify
    fileID=fopen(file,'r'); % change this according to what you want to classify
    lines_pca=textscan(fileID,'%s%f%f%d');
    fclose(fileID);
    
    Params_nonexisting=[lines_pca{2} lines_pca{3}];
    Class_nonexisting=[lines_pca{4}];
    
    Params=[Params_existing;Params_nonexisting];
    Class=[Class_existing;Class_nonexisting];

    for k = 1:10 % number of neighbors for kNN, 1-19 with only odd numbers
        Mdl = fitcknn(Params,Class,'NumNeighbors',2*k-1,'Kfold',10);
        Loss_percentage(trial,k)=Mdl.kfoldLoss(); % 10 fold cross validation       
    end
end

Loss_percentage;

meanCorrectPerc_lin = 100 - mean(Loss_percentage)*100;
maxCorrectPerc_lin = 100 - min(Loss_percentage)*100;
minCorrectPerc_lin = 100 - max(Loss_percentage)*100;
[meanCorrectPerc_lin.', maxCorrectPerc_lin.', minCorrectPerc_lin.']

%% KNN Polynomial fit
fileID=fopen('DualExisting_pca_poly.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

Loss_percentage=zeros(10,10);

for trial = 1:10
    
    file=sprintf('DualNonExisting_pca_poly_%d.txt',trial); % change this according to what you want to classify
    fileID=fopen(file,'r'); % change this according to what you want to classify
    lines_pca=textscan(fileID,'%s%f%f%d');
    fclose(fileID);
    
    Params_nonexisting=[lines_pca{2} lines_pca{3}];
    Class_nonexisting=[lines_pca{4}];
    
    Params=[Params_existing;Params_nonexisting];
    Class=[Class_existing;Class_nonexisting];

    for k = 1:10
        Mdl = fitcknn(Params,Class,'NumNeighbors',2*k-1,'Kfold',10);
        Loss_percentage(trial,k)=Mdl.kfoldLoss();       
    end
end

Loss_percentage;

meanCorrectPerc_poly = 100 - mean(Loss_percentage)*100;
maxCorrectPerc_poly = 100 - min(Loss_percentage)*100;
minCorrectPerc_poly = 100 - max(Loss_percentage)*100;
[meanCorrectPerc_poly.', maxCorrectPerc_poly.', minCorrectPerc_poly.']

results = [meanCorrectPerc_lin.', maxCorrectPerc_lin.', minCorrectPerc_lin.', meanCorrectPerc_poly.', maxCorrectPerc_poly.', minCorrectPerc_poly.'];
input.data = results;
input.tableColLabels = {'mean', 'max', 'min', 'mean', 'max', 'min'};
input.dataFormat = {'%.2f',6};
latex = latexTable(input);