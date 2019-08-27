% This script predicts for remaining graphs not in positive/negative
% traning data sets, based on kNN models using k value that gives best
% performance in 'kNN_clustering' script.
% Negative sample set 1 used, decided randomly, can choose other sets.

%% Linear KNN, k=9 for tree graphs, k=19 for dual graphs, Negative set 1
clc;
clear all;

% Record the remaining data
fileID=fopen('DualExisting_pca.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
existingID = string(lines_pca{1});
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

file=sprintf('DualNonExisting_pca_%d.txt',1); % change this according to what you want to classify
fileID=fopen(file,'r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
nonExistingID = string(lines_pca{1});
Params_nonexisting=[lines_pca{2} lines_pca{3}];
Class_nonexisting=[lines_pca{4}];

fileID=fopen('DualGraphParams_pca.txt', 'r'); % change this according to what you want to classify
lines=textscan(fileID,'%s%f%f');
fclose(fileID);
graphID=string(lines{1});
allParams = [lines{2} lines{3}];
rem_ID = strings(length(graphID)-length(existingID)-length(nonExistingID),1);
rem_Params = zeros(length(rem_ID),2);

Params=[Params_existing;Params_nonexisting];
Class=[Class_existing;Class_nonexisting];
Mdl = fitcknn(Params,Class,'NumNeighbors',19); % change this according to what you want to classify

k = 0;
for i = 1:size(graphID)
    rem = true;
    j = 1;
    while rem && j<=length(existingID)
        if strcmp(graphID(i), existingID(j))
            rem = false;
        else
            j = j+1;
        end
    end
    j = 1;
    while rem && j<=length(nonExistingID)
        if strcmp(graphID(i), nonExistingID(j))
            rem = false;
        else
            j = j+1;
        end
    end
    if rem
        k = k+1;
        rem_ID(k) = graphID(i);
        rem_Params(k,:) = allParams(i,:);
    end
end

writematrix([rem_ID rem_Params],'DualRemaining_pca_1.txt','Delimiter','tab'); % change this according to what you want to classify

fileID=fopen('DualRemaining_pca_1.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);
GraphIDs=string(lines_pca{1});
Params_predict=[lines_pca{2} lines_pca{3}];

Labels = predict(Mdl,Params_predict);
writematrix([GraphIDs Params_predict Labels],'DualRemaining_pca_labels_k19_1.txt','Delimiter','tab'); % change this according to what you want to classify

%% Poly KNN, k=9 for tree graphs, k=19 for dual graphs, Negative set 1
clc;
clear all;

% Record the remaining data
fileID=fopen('DualExisting_pca_poly.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
existingID = string(lines_pca{1});
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

file=sprintf('DualNonExisting_pca_poly_%d.txt',1); % change this according to what you want to classify
fileID=fopen(file,'r');
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
nonExistingID = string(lines_pca{1});
Params_nonexisting=[lines_pca{2} lines_pca{3}];
Class_nonexisting=[lines_pca{4}];

fileID=fopen('DualGraphParams_pca_poly.txt', 'r'); % change this according to what you want to classify
lines=textscan(fileID,'%s%f%f');
fclose(fileID);
graphID=string(lines{1});
allParams = [lines{2} lines{3}];
rem_ID = strings(length(graphID)-length(existingID)-length(nonExistingID),1);
rem_Params = zeros(length(rem_ID),2);

Params=[Params_existing;Params_nonexisting];
Class=[Class_existing;Class_nonexisting];
Mdl = fitcknn(Params,Class,'NumNeighbors',19); % change this according to what you want to classify

k = 0;
for i = 1:size(graphID)
    rem = true;
    j = 1;
    while rem && j<=length(existingID)
        if strcmp(graphID(i), existingID(j))
            rem = false;
        else
            j = j+1;
        end
    end
    j = 1;
    while rem && j<=length(nonExistingID)
        if strcmp(graphID(i), nonExistingID(j))
            rem = false;
        else
            j = j+1;
        end
    end
    if rem
        k = k+1;
        rem_ID(k) = graphID(i);
        rem_Params(k,:) = allParams(i,:);
    end
end

writematrix([rem_ID rem_Params],'DualRemaining_pca_poly_1.txt','Delimiter','tab'); % change this according to what you want to classify

fileID=fopen('DualRemaining_pca_poly_1.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f');
fclose(fileID);
GraphIDs=string(lines_pca{1});
Params_predict=[lines_pca{2} lines_pca{3}];

Labels = predict(Mdl,Params_predict);
writematrix([GraphIDs Params_predict Labels],'DualRemaining_pca_labels_poly_k19_1.txt','Delimiter','tab'); % change this according to what you want to classify