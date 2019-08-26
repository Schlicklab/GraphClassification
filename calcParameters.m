clc;
clear all;

data = load('DualVertexGraphCounts.txt'); % change the name of the file to be Tree or Dual

% calculate the four parameters
%Params = zeros(sum(data(:,2)),4);
Params = zeros(sum(data(:,2)),5);
GraphIDs = strings(sum(data(:,2)),1);
MSE = zeros(1, length(data(:,1)));
MSE_sq = zeros(1, length(data(:,1)));

for i = 1:size(data,1) % for every vertex number
    MSE1 = zeros(1, data(i,2));
    MSE2 = zeros(1, data(i,2));
    for g = 1:data(i,2) % for all graphs with vertex number v
        
        graph_file = sprintf('DualEigenVals/%d_%d',data(i,1),g); % change the name of the file to be Tree or Dual
        [vals, mse1, mse2]=calcParams(graph_file,data(i,1)); 
        graph = sprintf('%d_%d',data(i,1),g);
        GraphIDs(sum(data(1:i-1,2))+g) = string(graph);
        Params(sum(data(1:i-1,2))+g, :) = vals;
        
        MSE1(g) = mse1;
        MSE2(g) = mse2;
    end
    MSE(i) = mean(MSE1);
    MSE_sq(i) = mean(MSE2);
end

%save('DualMSE_lin.mat', 'MSE', 'MSE_sq');
save('DualMSE_poly.mat', 'MSE', 'MSE_sq');

% % normalize the parameters
% average = mean(abs(Params)); % average of all the four coordinates
% %Params_norm = [Params(:,1)*average(1)/average(1) Params(:,2)*average(1)/average(2) Params(:,3)*average(1)/average(3) Params(:,4)*average(1)/average(4)];
% Params_norm = [Params(:,1)*average(1)/average(1) Params(:,2)*average(1)/average(2) Params(:,3)*average(1)/average(3) Params(:,4)*average(1)/average(4) Params(:,5)*average(1)/average(5)];
% %writematrix([GraphIDs Params_norm],'DualGraphParams_norm.txt','Delimiter','tab'); % change the name of the file to be Tree or Dual
% writematrix([GraphIDs Params_norm],'DualGraphParams_norm_sq.txt','Delimiter','tab'); % change the name of the file to be Tree or Dual
% 
% % PCA on parameters to project data on first two components 
% [coeff] = pca(Params_norm);
% First_two_coeff = coeff(:,1:2);
% Reduced_Params = Params_norm*First_two_coeff;
% %writematrix([GraphIDs Reduced_Params],'DualGraphParams_pca.txt','Delimiter','tab');% change the name of the file to be Tree or Dual
% writematrix([GraphIDs Reduced_Params],'DualGraphParams_pca_sq.txt','Delimiter','tab');% change the name of the file to be Tree or Dual

% % cmds on parameters to reduce to two dimensions
% dis_temp = pdist(Params_norm);
% %dis_temp = pdist(Params_norm(1:17876,:)); % for dual graphs upto 8
% %vertices
% dis = squareform(dis_temp);
% [CMDS_Params,e] = cmdscale(dis,2);
% %writematrix([GraphIDs CMDS_Params],'TreeGraphParams_cmds.txt','Delimiter','tab');
% writematrix([GraphIDs CMDS_Params],'DualGraphParams_cmds_sq.txt','Delimiter','tab');
% %writematrix([GraphIDs(1:17876)
% %CMDS_Params],'DualGraphParams_8Vcmds.txt','Delimiter','tab'); % for dual graphs upto 8
% %vertices


%% Plots
clc;

data = load('TreeVertexGraphCounts.txt'); % change the name of the file to be Tree or Dual
i = 11; %vertex number
g = data(i,2); %graph number for vertex i        
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
    
    param_1_lin= linsolve(A,Eigenvals); % [intercept, slope]    
    %Do second order polynomial fit for Eigenvals and plot to compare the
    %two fits
    param_1_poly = polyfit([1:n-1], Eigenvals.', 2);
    
    figure(1);
    t = sprintf('Tree Graph %d_%d', v+2, g);
    sgtitle(t, 'Interpreter', 'none', 'FontSize', 30);
    set(gcf,'color','w');
    
    subplot(2,2,1);
    hold on;
    plot([1:n-1], Eigenvals, 'x', 'MarkerSize', 10);
    y = @(x) param_1_lin(2)*x + param_1_lin(1);
    x = linspace(0, n-1, n^2);
    plot(x, y(x), 'LineWidth', 2);
    title('Linear Fit for Eigenvalues', 'FontSize', 20);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',18);
    hold off;
    
    subplot(2,2,2);
    hold on;
    plot([1:n-1], Eigenvals, 'x', 'MarkerSize', 10);
    y = @(x) param_1_poly(1)*x.^2 + param_1_poly(2)*x + param_1_poly(3);
    x = linspace(0, n-1, n^2);
    plot(x, y(x), 'LineWidth', 2);
    title('Quadratic Fit for Eigenvalues', 'FontSize', 20);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',18);
    hold off;
    
    param_2_lin = linsolve(A,Eigenvals_sq);
    param_2_poly = polyfit([1:n-1], Eigenvals_sq.', 2);
    
    subplot(2,2,3);
    hold on;
    plot([1:n-1], Eigenvals_sq, 'x', 'MarkerSize', 10);
    y = @(x) param_2_lin(2)*x + param_2_lin(1);
    x = linspace(0, n-1, n^2);
    plot(x, y(x), 'LineWidth', 2);
    title('Linear Fit for Squared Eigenvalues', 'FontSize', 20);
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',18);
    hold off;
    
    subplot(2,2,4);
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
function [val, MSE1, MSE2] = calcParams(filename,n)

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
    
    %param_1 = linsolve(A,Eigenvals); % [intercept, slope]
    param_1 = polyfit([1:n-1], Eigenvals.', 2);
    %MSE1 = mean((Eigenvals.' - ([i:n-1]*param_1(2)+param_1(1))) .^2); %Mean square error to see which kind of regression is better
    MSE1 = mean((Eigenvals.' - ([i:n-1].^2*param_1(1)+[i:n-1]*param_1(2)+param_1(3))) .^2);
    
    %param_2 = linsolve(A,Eigenvals_sq);
    param_2 = polyfit([i:n-1], Eigenvals_sq.', 2);
    %MSE2 = mean((Eigenvals_sq.' - ([i:n-1]*param_2(2)+param_2(1))) .^2);
    MSE2 = mean((Eigenvals_sq.' - ([i:n-1].^2*param_2(1)+[i:n-1]*param_2(2)+param_2(3))) .^2);

    %param_1(2) = param_1(2)*n; % scaling the slope with number of vertices
    %param_2(2) = param_2(2)*n;
    
    %val = [param_1(2) param_1(1) param_2(2) param_2(1)];
    val = [param_1(2) param_1(1) param_2(1) param_2(2) param_2(3)];
end