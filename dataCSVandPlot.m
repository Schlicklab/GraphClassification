%% Process the MSEs data to CSV file
clc;
clear all;

% Tree graphs
header = {'Vertex No.' 'Eigens/Linear' 'Eigens/Polynomial' 'Squared Eigens/Linear' 'Squared Eigens/Polynomial'};
textHeader = strjoin(header, ',');
fid = fopen('TreeMSE.csv','w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
% write data to end of file
c1 = [3:13].';
c2 = load('TreeMSE.mat', 'MSE_lin');
c2 = cell2mat(struct2cell(c2)).';
c3 = load('TreeMSE.mat', 'MSE_poly');
c3 = cell2mat(struct2cell(c3)).';
c4 = load('TreeMSE.mat', 'MSE_sq_lin');
c4 = cell2mat(struct2cell(c4)).';
c5 = load('TreeMSE.mat', 'MSE_sq_poly');
c5 = cell2mat(struct2cell(c5)).';
data = [c1, c2, c3, c4, c5];
dlmwrite('TreeMSE.csv',data,'-append');

% Dual graphs
header = {'Vertex No.' 'Eigens/Linear' 'Eigens/Polynomial' 'Squared Eigens/Linear' 'Squared Eigens/Polynomial'};
textHeader = strjoin(header, ',');
fid = fopen('DualMSE.csv','w'); 
fprintf(fid,'%s\n',textHeader);
fclose(fid);
% write data to end of file
c1 = [3:9].';
c2 = load('DualMSE.mat', 'MSE_lin');
c2 = cell2mat(struct2cell(c2)).';
c3 = load('DualMSE.mat', 'MSE_poly');
c3 = cell2mat(struct2cell(c3)).';
c4 = load('DualMSE.mat', 'MSE_sq_lin');
c4 = cell2mat(struct2cell(c4)).';
c5 = load('DualMSE.mat', 'MSE_sq_poly');
c5 = cell2mat(struct2cell(c5)).';
data = [c1, c2, c3, c4, c5];
dlmwrite('DualMSE.csv',data,'-append');


%% Plot MSEs
clc;
clear all;

c1 = [3:13].';
c2 = load('TreeMSE.mat', 'MSE_sq_lin');
c2 = cell2mat(struct2cell(c2)).';
c3 = load('TreeMSE.mat', 'MSE_sq_poly');
c3 = cell2mat(struct2cell(c3)).';
figure(1);
hold on;
plot(c1, c2, '-o', 'MarkerSize', 10, 'LineWidth', 2);
plot(c1, c3, '-^', 'MarkerSize', 10, 'LineWidth', 2);
legend('Linear Regression MSEs','Quadratic Regression MSEs', 'Location', 'northwest', 'FontSize', 30);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
set(gcf,'color','w');
title('Tree Linear/Quadratic MSEs for Squared Eigenvalues', 'FontSize', 40);
xlabel('Number of Vertices');
hold off;

c1 = [3:9].';
c2 = load('DualMSE.mat', 'MSE_sq_lin');
c2 = cell2mat(struct2cell(c2)).';
c3 = load('DualMSE.mat', 'MSE_sq_poly');
c3 = cell2mat(struct2cell(c3)).';
figure(2);
hold on;
plot(c1, c2, '-o', 'MarkerSize', 10, 'LineWidth', 2);
plot(c1, c3, '-^', 'MarkerSize', 10, 'LineWidth', 2);
legend('Linear Regression MSEs','Quadratic Regression MSEs', 'FontSize', 30);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',30);
set(gcf,'color','w');
title('Dual Linear/Quadratic MSEs for Squared Eigenvalues', 'FontSize', 40);
legend('Linear Regression MSEs','Quadratic Regression MSEs', 'Location', 'northwest', 'FontSize', 30);
xlabel('Number of Vertices');
hold off;




