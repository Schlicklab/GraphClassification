data = load('TreeVertexGraphCounts.txt'); % change the name of the file to be Tree or Dual

% calculate the four parameters
fileID = fopen('TreeGraphParams_unnorm.txt','w'); % change the name of the file to be Tree or Dual
Params = [];
GraphIDs = [];
for i = 1:size(data,1), % for every vertex number
    for g = 1:data(i,2), % for all graphs with vertex number v
        
        graph_file = sprintf('TreeEigenVals/%d_%d',data(i,1),g); % change the name of the file to be Tree or Dual
        vals=calcParams(graph_file,data(i,1)); 
        graph = sprintf('%d_%d',data(i,1),g);
        fprintf(fileID,"%s\t%f\t%f\t%f\t%f\n",graph,vals(1),vals(2),vals(3),vals(4));
        GraphIDs = [GraphIDs;string(graph)];
        Params = [Params;vals];
    end
end
fclose(fileID);

% normalize the parameters
average = mean(abs(Params)); % average of all the four coordinates
Params_norm = [Params(:,1)*average(1)/average(1) Params(:,2)*average(1)/average(2) Params(:,3)*average(1)/average(3) Params(:,4)*average(1)/average(4)];
writematrix([GraphIDs Params_norm],'TreeGraphParams_norm.txt','Delimiter','tab'); % change the name of the file to be Tree or Dual

% PCA on parameters to project data on first two components 
[coeff] = pca(Params_norm);
First_two_coeff = coeff(:,1:2);
Reduced_Params = Params_norm*First_two_coeff;
writematrix([GraphIDs Reduced_Params],'TreeGraphParams_pca.txt','Delimiter','tab');% change the name of the file to be Tree or Dual

% cmds on parameters to reduce to two dimensions
dis_temp = pdist(Params_norm);
%dis_temp = pdist(Params_norm(1:17876,:)); % for dual graphs upto 8
%vertices
dis = squareform(dis_temp);
[CMDS_Params,e] = cmdscale(dis,2);
writematrix([GraphIDs CMDS_Params],'TreeGraphParams_cmds.txt','Delimiter','tab');
%writematrix([GraphIDs(1:17876)
%CMDS_Params],'DualGraphParams_8Vcmds.txt','Delimiter','tab'); % for dual graphs upto 8
%vertices


function val = calcParams(filename,n)

    file=fopen(filename,'r'); % reading the eigenvalues
    formatSpec = '%f';
    Eigenvals = fscanf(file,formatSpec); % eigenvalues vector
    fclose(file);
    Eigenvals_sq = Eigenvals.^2; % square of eigenvalues vector
    
    A = [1:n-1];
    A = A';
    A = [ones(n-1,1) A]; % the A matrix for solving the linear system
    
    param_1 = linsolve(A,Eigenvals); % [intercept, slope]
    param_2 = linsolve(A,Eigenvals_sq);
    param_1(2) = param_1(2)*n; % scaling the slope with number of vertices
    param_2(2) = param_2(2)*n;
    
    val = [param_1(2) param_1(1) param_2(2) param_2(1)];    
end