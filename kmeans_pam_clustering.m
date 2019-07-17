%reading pca files
fileID=fopen('DualGraphParams_pca.txt','r'); %change to read whatever parameters you want
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);

GraphIDs=string(lines_pca{1});
Params = [lines_pca{2} lines_pca{3}];

%K-means clustering on the data
[idx,C] = kmeans(Params,2,'Display','iter');
writematrix([GraphIDs idx],'Dual_pca_kmeans.txt','Delimiter','tab');
subplot(2,2,1);
colors = [0 0 1; 0 0 0];
gscatter(Params(:,1),Params(:,2),idx,colors,'.',[20;20]);

%K-medoids clustering on the data - by default it is PAM
[idx,C] = kmedoids(Params,2);
writematrix([GraphIDs idx],'Dual_pca_pam.txt','Delimiter','tab');
subplot(2,2,2);
colors = [0 0 1; 0 0 0];
gscatter(Params(:,1),Params(:,2),idx,colors,'.',[20;20]);

%reading cmds files
fileID=fopen('DualGraphParams_8Vcmds.txt','r'); %change to read whatever parameters you want
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);

GraphIDs=string(lines_pca{1});
Params = [lines_pca{2} lines_pca{3}];

%K-means clustering on the data
[idx,C] = kmeans(Params,2,'Display','iter');
writematrix([GraphIDs idx],'Dual_8Vcmds_kmeans.txt','Delimiter','tab');
subplot(2,2,3);
colors = [0 0 1; 0 0 0];
gscatter(Params(:,1),Params(:,2),idx,colors,'.',[20;20]);

%K-medoids clustering on the data - by default it is PAM
[idx,C] = kmedoids(Params,2);
writematrix([GraphIDs idx],'Dual_8Vcmds_pam.txt','Delimiter','tab');
subplot(2,2,4);
colors = [0 0 1; 0 0 0];
gscatter(Params(:,1),Params(:,2),idx,colors,'.',[20;20]);