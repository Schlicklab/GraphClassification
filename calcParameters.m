% This script calculates the normed 2 parameters for each tree/dual graph
% after PCA/MDS

clc;
clear all;

data = load('DualVertexGraphCounts.txt'); % change the name of the file to be Tree or Dual

% calculate the new five parameters using polyfit
Params = zeros(sum(data(:,2)),5);
GraphIDs = strings(sum(data(:,2)),1);
MSE_lin = zeros(1, length(data(:,1))); % MSE averages for eigenvalues for each vertex number, linear regression used
MSE_poly = zeros(1, length(data(:,1))); % MSE averages for eigenvalues for each vertex number, poly regression used
MSE_sq_lin = zeros(1, length(data(:,1))); % MSE averages for squared eigenvalues for each vertex number, linear regression used
MSE_sq_poly = zeros(1, length(data(:,1))); % MSE averages for squared eigenvalues for each vertex number, poly regression used

for i = 1:size(data,1) % for every vertex number
    
    MSE1_lin = zeros(1, data(i,2)); % MSEs for each graph eigenvalues with vertex number v, linear regression
    MSE1_poly = zeros(1, data(i,2)); % MSEs, eigenvalues, poly regression
    MSE2_lin = zeros(1, data(i,2)); % MSEs, squared eigenvalues, linear regression
    MSE2_poly = zeros(1, data(i,2)); % MSEs, squared eigenvalues, poly regression
    
    for g = 1:data(i,2) % for all graphs with vertex number v
        
        graph_file = sprintf('DualEigenVals/%d_%d',data(i,1),g); % change the name of the file to be Tree or Dual
        [vals, mse1_lin, mse1_poly, mse2_lin, mse2_poly]=calcParams(graph_file,data(i,1)); 
        graph = sprintf('%d_%d',data(i,1),g);
        GraphIDs(sum(data(1:i-1,2))+g) = string(graph);
        Params(sum(data(1:i-1,2))+g, :) = vals;
        
        MSE1_lin(g) = mse1_lin;
        MSE1_poly(g) = mse1_poly;
        MSE2_lin(g) = mse2_lin;
        MSE2_poly(g) = mse2_poly;
    end
    
    MSE_lin(i) = round(mean(MSE1_lin),3); % keep only 3 decimals
    MSE_poly(i) = round(mean(MSE1_poly),3);
    MSE_sq_lin(i) = round(mean(MSE2_lin),3);
    MSE_sq_poly(i) = round(mean(MSE2_poly),3);
    
end

save('DualMSE.mat', 'MSE_lin', 'MSE_poly', 'MSE_sq_lin', 'MSE_sq_poly'); % change this according to what you want to classify

% normalize the parameters based on the averages
average = mean(abs(Params)); % average of all the five coordinates
Params_norm = [Params(:,1)*average(1)/average(1) Params(:,2)*average(1)/average(2) Params(:,3)*average(1)/average(3) Params(:,4)*average(1)/average(4) Params(:,5)*average(1)/average(5)];
writematrix([GraphIDs Params_norm],'DualGraphParams_norm_poly.txt','Delimiter','tab'); % change the name of the file to be Tree or Dual

% PCA on parameters to project data on first two components 
[coeff] = pca(Params_norm);
First_two_coeff = coeff(:,1:2);
Reduced_Params = Params_norm*First_two_coeff;
writematrix([GraphIDs Reduced_Params],'DualGraphParams_pca_poly.txt','Delimiter','tab');% change the name of the file to be Tree or Dual

% % cmds on parameters to reduce to two dimensions
% dis_temp = pdist(Params_norm);
% %dis_temp = pdist(Params_norm(1:17876,:)); % for dual graphs upto 8 vertices
% dis = squareform(dis_temp);
% [CMDS_Params,e] = cmdscale(dis,2);
% writematrix([GraphIDs CMDS_Params],'DualGraphParams_cmds_poly.txt','Delimiter','tab');
% %writematrix([GraphIDs(1:17876)
% %CMDS_Params],'DualGraphParams_8Vcmds.txt','Delimiter','tab'); % for dual graphs upto 8
% %vertices


%% Plots of the regression fits for certain tree/dual graphs
clc;

data = load('TreeVertexGraphCounts.txt'); % change the name of the file to be Tree or Dual
i = 11; % vertex number (-2 as start from 3) of the graph you want to plot for, tree:1-11, dual:1-7
g = data(i,2); % the specific graph number      
graph_file = sprintf('TreeEigenVals/%d_%d',data(i,1),g); % change the name of the file to be Tree or Dual
fitPlot(graph_file,data(i,1), i, g);

function fitPlot(filename,n, v, g)

    file=fopen(filename,'r'); % reading the eigenvalues
    formatSpec = '%f';
    Eigenvals = fscanf(file,formatSpec); % eigenvalues vector
    fclose(file);
    Eigenvals_sq = Eigenvals.^2; % square of eigenvalues vector
    A = [1:n-1];
    A = A';
    A = [ones(n-1,1) A]; % the A matrix for solving the linear system
    
    % Do linear and quadratic polynomial fits for Eigenvals
    param_1_lin= linsolve(A,Eigenvals); % [intercept, slope]    
    param_1_poly = polyfit([1:n-1], Eigenvals.', 2);
    
    figure(1);
    t = sprintf('Tree Graph %d_%d', v+2, g); % change this according to what you want to classify
    sgtitle(t, 'Interpreter', 'none', 'FontSize', 30);
    set(gcf,'color','w');
    
    subplot(2,2,1); %plot fit for eigenvalues using linear regression
    hold on;
    plot([1:n-1], Eigenvals, 'x', 'MarkerSize', 10);
    y = @(x) param_1_lin(2)*x + param_1_lin(1);
    x = linspace(0, n-1, n^2);
    plot(x, y(x), 'LineWidth', 2);
    title('Linear Fit for Eigenvalues', 'FontSize', 20);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',18);
    hold off;
    
    subplot(2,2,2); %plot fit for eigenvalues using polynomial regression
    hold on;
    plot([1:n-1], Eigenvals, 'x', 'MarkerSize', 10);
    y = @(x) param_1_poly(1)*x.^2 + param_1_poly(2)*x + param_1_poly(3);
    x = linspace(0, n-1, n^2);
    plot(x, y(x), 'LineWidth', 2);
    title('Quadratic Fit for Eigenvalues', 'FontSize', 20);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',18);
    hold off;
    
    
    % Do linear and quadratic polynomial fits for Squared Eigenvals
    param_2_lin = linsolve(A,Eigenvals_sq);
    param_2_poly = polyfit([1:n-1], Eigenvals_sq.', 2);
    
    subplot(2,2,3); %plot fit for squared eigenvalues using linear regression
    hold on;
    plot([1:n-1], Eigenvals_sq, 'x', 'MarkerSize', 10);
    y = @(x) param_2_lin(2)*x + param_2_lin(1);
    x = linspace(0, n-1, n^2);
    plot(x, y(x), 'LineWidth', 2);
    title('Linear Fit for Squared Eigenvalues', 'FontSize', 20);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',18);
    hold off;
    
    subplot(2,2,4); %plot fit for squared eigenvalues using polynomial regression
    hold on;
    plot([1:n-1], Eigenvals_sq, 'x', 'MarkerSize', 10);
    y = @(x) param_2_poly(1)*x.^2 + param_2_poly(2)*x + param_2_poly(3);
    x = linspace(0, n-1, n^2);
    plot(x, y(x), 'LineWidth', 2);
    title('Quadratic Fit for Squared Eigenvalues', 'FontSize', 20);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',18);
    hold off;
end


%%
function [val, MSE1_lin, MSE1_poly, MSE2_lin, MSE2_poly] = calcParams(filename,n)

    file=fopen(filename,'r'); % reading the eigenvalues
    formatSpec = '%f';
    Eigenvals = fscanf(file,formatSpec); % eigenvalues vector
    fclose(file);
    Eigenvals_sq = Eigenvals.^2; % square of eigenvalues vector
    
%     %For especially Tree graphs, for each vertex, the last portion of the
%     %graphs tends to have repeated eigenvalues of 1 (mostly obvious for vertex
%     %13, where the last graph can have 12 eigenvalues of 1). Then neither
%     %linear nor 2nd order polynomial fits can work well. Hence, when there
%     %are 3 or more repeated eigenvalues of 1, we only keep the last 1 when
%     %doing regression. Interestingly, if we do this, after pca, almost
%     %all points are classified into one cluster using kmeans clustering. If
%     %we remove the outliers, then not much improvement.
%     A = [1:n-1];
%     A = A';
%     A = [ones(n-1,1) A]; % the A matrix for solving the linear system
    i = 1;
%     if n > 4 && isequal(Eigenvals(1:3),ones(3,1))
%         while i<=n-1 && Eigenvals(i)==1
%             i = i+1;
%         end
%         i = i-1;
%         Eigenvals = Eigenvals(i:n-1);
%         Eigenvals_sq = Eigenvals_sq(i:n-1);
%     end
    A = [i:n-1];
    A = A';
    A = [ones(n-i,1) A]; % the A matrix for solving the linear system
    
    % Use linear regression for eigenvalues
    param_1 = linsolve(A,Eigenvals); % [intercept, slope]
    MSE1_lin = mean((Eigenvals.' - ([i:n-1]*param_1(2)+param_1(1))) .^2);
    % Calculate MSE of quadratic polynomial regression for eigenvalues
    coeff = polyfit([i:n-1], Eigenvals.', 2); % coefficients of the quadratic polynomial fitted
    MSE1_poly = mean((Eigenvals.' - ([i:n-1].^2*coeff(1)+[i:n-1]*coeff(2)+coeff(3))) .^2);
    
    % Use linear regression for squared eigenvalues
    param_2 = polyfit([i:n-1], Eigenvals_sq.', 2);
    MSE2_poly = mean((Eigenvals_sq.' - ([i:n-1].^2*param_2(1)+[i:n-1]*param_2(2)+param_2(3))) .^2);
    % Calculate MSE of linear regression for squared eigenvalues
    coeff = linsolve(A,Eigenvals_sq); % [intercept, slope]
    MSE2_lin = mean((Eigenvals_sq.' - ([i:n-1]*coeff(2)+coeff(1))) .^2);

    param_1(2) = param_1(2)*n; % scaling the slope with number of vertices
    
    val = [param_1(2) param_1(1) param_2(1) param_2(2) param_2(3)];
end