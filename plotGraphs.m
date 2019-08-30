% plot kmeans and pam clusters
fileID=fopen('TreeGraphParams_pca_poly.txt','r'); %change to read whatever parameters you want
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);
Params=[lines_pca{2} lines_pca{3}];
fileID=fopen('Tree_pca_kmeans_poly.txt','r'); %change to read whatever parameters you want
lines_pca=textscan(fileID,'%s%d');
fclose(fileID);
Class=[lines_pca{2}];
colors = [0 0 1; 0 0 0];
gscatter(Params(:,1),Params(:,2),Class,colors,'.',[20;20]);
hold
fileID=fopen('TreeExisting_pca_poly.txt','r');
lines_pca=textscan(fileID,'%s%f%f%d');
Params=[lines_pca{2} lines_pca{3}];
scatter(Params(:,1),Params(:,2),'r','filled');
set(gca,'FontSize', 25);
C = [8.6771   -0.3178; 22.6103   -1.1087]; % change this to what you are plotting
scatter(C(:,1),C(:,2),80,'g','d','filled');
legend('RNA-like','Non RNA-like','Existing','Centers'); % change Medoids to Centers for k-means

% plot kNN clusters
%fileID=fopen('DualExisting_pca.txt','r'); %change to read whatever parameters you want
%lines_pca=textscan(fileID,'%s%f%f%d');
%fclose(fileID);
%Params_existing=[lines_pca{2} lines_pca{3}];
%Class_existing=[lines_pca{4}];
%fileID=fopen('DualNonExisting_pca_final.txt','r'); %change to read whatever parameters you want
%lines_pca=textscan(fileID,'%s%f%f%d');
%fclose(fileID);
%Params_nonexisting=[lines_pca{2} lines_pca{3}];
%Class_nonexisting=[lines_pca{4}];
%fileID=fopen('DualRemaining_pca_final_labeldata_k2.txt','r'); %change to read whatever parameters you want
%lines_pca=textscan(fileID,'%s%f%f%d');
%fclose(fileID);
%Params_rem=[lines_pca{2} lines_pca{3}];
%Class_rem=[lines_pca{4}];

%Params=[Params_existing;Params_nonexisting;Params_rem];
%Class=[Class_existing;Class_nonexisting;Class_rem];
%colors = [0 0 1; 0 0 0];
%gscatter(Params(:,1),Params(:,2),Class,colors,'.',[20;20]);
%hold
%scatter(Params_existing(:,1),Params_existing(:,2),'r','filled');
%set(gca,'FontSize', 25)
%legend('RNA-like','Non RNA-like','Existing');
