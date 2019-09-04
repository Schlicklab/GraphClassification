% This script calculates the normed 2 parameters for each Dual/Dual graph
% after PCA/MDS

clc;
clear all;

fileID=fopen('DualMisclassifyID_PAM_lin.txt','r'); %change to read whatever parameters you want
lines_pca=textscan(fileID,'%s');
fclose(fileID);
GraphIDs=string(lines_pca{1});
vertexNo = zeros(1, length(GraphIDs));
graphNo = zeros(1, length(GraphIDs));
for i = 1:length(GraphIDs)
    num = sscanf(GraphIDs(i), '%d_%d.csv');
    vertexNo(i) = num(1);
    graphNo(i) = num(2);
end

MSE_lin = zeros(1, length(vertexNo)); % MSE for eigenvalues for each misclassified graph, linear regression used
MSE_poly = zeros(1, length(vertexNo)); % MSE for eigenvalues for each misclassified graph, poly regression used
MSE_sq_lin = zeros(1, length(vertexNo)); % MSE for squared eigenvalues for each misclassified graph, linear regression used
MSE_sq_poly = zeros(1, length(vertexNo)); % MSE for squared eigenvalues for each misclassified graph, poly regression used

for i = 1:length(vertexNo) % for every vertex number

    graph_file = sprintf('DualEigenVals/%d_%d',vertexNo(i),graphNo(i)); % change the name of the file to be Dual or Dual
    [MSE_lin(i), MSE_poly(i), MSE_sq_lin(i), MSE_sq_poly(i)]=calcParams(graph_file,vertexNo(i));
    
end

save('DualMisclassifyMSE_lin.mat', 'vertexNo', 'graphNo', 'MSE_lin', 'MSE_sq_lin'); % change this according to what you want to classify


function [MSE1_lin, MSE1_poly, MSE2_lin, MSE2_poly] = calcParams(filename,n)

    file=fopen(filename,'r'); % reading the eigenvalues
    formatSpec = '%f';
    Eigenvals = fscanf(file,formatSpec); % eigenvalues vector
    fclose(file);
    Eigenvals_sq = Eigenvals.^2; % square of eigenvalues vector
    
    A = [1:n-1];
    A = A';
    A = [ones(n-1,1) A]; % the A matrix for solving the linear system
    
    % Use linear regression for eigenvalues
    param_1 = linsolve(A,Eigenvals); % [intercept, slope]
    MSE1_lin = mean((Eigenvals.' - ([1:n-1]*param_1(2)+param_1(1))) .^2);
    % Calculate MSE of quadratic polynomial regression for eigenvalues
    coeff = polyfit([1:n-1], Eigenvals.', 2); % coefficients of the quadratic polynomial fitted
    MSE1_poly = mean((Eigenvals.' - ([1:n-1].^2*coeff(1)+[1:n-1]*coeff(2)+coeff(3))) .^2);
    
    % Use linear regression for squared eigenvalues
    param_2 = polyfit([1:n-1], Eigenvals_sq.', 2);
    MSE2_poly = mean((Eigenvals_sq.' - ([1:n-1].^2*param_2(1)+[1:n-1]*param_2(2)+param_2(3))) .^2);
    % Calculate MSE of linear regression for squared eigenvalues
    coeff = linsolve(A,Eigenvals_sq); % [intercept, slope]
    MSE2_lin = mean((Eigenvals_sq.' - ([1:n-1]*coeff(2)+coeff(1))) .^2);
    
end