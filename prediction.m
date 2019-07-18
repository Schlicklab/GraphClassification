fileID=fopen('TreeExisting_pca.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

fileID=fopen('TreeNonExisting_pca_final.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_nonexisting=[lines_pca{2} lines_pca{3}];
Class_nonexisting=[lines_pca{4}];

Params=[Params_existing;Params_nonexisting];
Class=[Class_existing;Class_nonexisting];

Mdl_cross = fitcknn(Params,Class,'NumNeighbors',2,'Leaveout','on');
Mdl_cross.kfoldLoss()

Mdl = fitcknn(Params,Class,'NumNeighbors',2);

fileID=fopen('TreeRemaining_pca_final.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);
GraphIDs=string(lines_pca{1});
Params_predict=[lines_pca{2} lines_pca{3}];

Labels = predict(Mdl,Params_predict);
writematrix([GraphIDs Labels],'TreeRemaining_pca_final_labels_k2.txt','Delimiter','tab');% change this according to what you want to classify