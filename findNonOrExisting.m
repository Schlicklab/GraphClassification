% This script find the existing or nonexisting graph IDs used in previous
% linear regression, and generate corresponding files for current
% parameters calculated using quadratic polynomial regression

clc;
clear all;

%% PCA
clc;
clear all;

fileID=fopen('DualExisting_pca.txt', 'r'); % change this according to what you want to classify
lines=textscan(fileID,'%s%f%f%d');
fclose(fileID);
existingID=string(lines{1});
N = length(existingID);
existingIDno = zeros(N,1);
existingParams = zeros(N, 2);

fileID=fopen('DualGraphParams_pca_poly.txt', 'r'); % change this according to what you want to classify
lines=textscan(fileID,'%s%f%f');
fclose(fileID);
graphID=string(lines{1});
Params = [lines{2} lines{3}];

j = 1;
for i = 1:N
    while (~strcmp(graphID(j), existingID(i)))
        j = j+1;
    end
    existingParams(i,:) = Params(j,:);
    existingIDno(i) = j;
end

Class = ones(N,1);

writematrix([existingID existingParams Class],'DualExisting_pca_poly.txt','Delimiter','tab'); % change this according to what you want to classify
writematrix(existingIDno,'DualExistingIdNo.txt'); % change this according to what you want to classify

for trial = 1:10
    file=sprintf('DualNonExisting_pca_%d.txt',trial); % change this according to what you want to classify
    fileID=fopen(file,'r');
    lines=textscan(fileID,'%s%f%f%d');
    fclose(fileID);
    nonExistingID=string(lines{1});
    N = length(nonExistingID);
    nonExistingParams = zeros(N, 2);
    
    fileID=fopen('DualGraphParams_pca_poly.txt', 'r'); % change this according to what you want to classify
    lines=textscan(fileID,'%s%f%f');
    fclose(fileID);
    graphID=string(lines{1});
    Params = [lines{2} lines{3}];
    
    for i = 1:N
        j = 1;
        while (~strcmp(graphID(j), nonExistingID(i)))
            j = j+1;
        end
        nonExistingParams(i,:) = Params(j,:);
    end
    file=sprintf('DualNonExisting_pca_poly_%d.txt', trial); % change this according to what you want to classify
    Class = ones(N,1)*2;
    writematrix([nonExistingID nonExistingParams Class], file, 'Delimiter','tab');
end

%% MDS
fileID=fopen('DualExisting_cmds.txt', 'r');
lines=textscan(fileID,'%s%f%f%d');
fclose(fileID);
existingID=string(lines{1});
N = length(existingID);
existingIDno = zeros(N,1);
existingParams = zeros(N, 2);

fileID=fopen('DualGraphParams_cmds_poly.txt', 'r');
lines=textscan(fileID,'%s%f%f');
fclose(fileID);
graphID=string(lines{1});
Params = [lines{2} lines{3}];

j = 1;
for i = 1:N
    while (~strcmp(graphID(j), existingID(i)))
        j = j+1;
    end
    existingParams(i,:) = Params(j,:);
    existingIDno(i) = j;
end

Class = ones(N,1);

writematrix([existingID existingParams Class],'DualExisting_cmds_poly.txt','Delimiter','tab');
writematrix(existingIDno,'DualExistingIdNo.txt');

for trial = 1:10
    file=sprintf('DualNonExisting_cmds_%d.txt',trial);
    fileID=fopen(file,'r');
    lines=textscan(fileID,'%s%f%f%d');
    fclose(fileID);
    nonExistingID=string(lines{1});
    N = length(nonExistingID);
    nonExistingParams = zeros(N, 2);
    
    fileID=fopen('DualGraphParams_cmds_poly.txt', 'r');
    lines=textscan(fileID,'%s%f%f');
    fclose(fileID);
    graphID=string(lines{1});
    Params = [lines{2} lines{3}];
    
    for i = 1:N
        j = 1;
        while (~strcmp(graphID(j), nonExistingID(i)))
            j = j+1;
        end
        nonExistingParams(i,:) = Params(j,:);
    end
    file=sprintf('DualNonExisting_cmds_poly_%d.txt', trial);
    Class = ones(N,1)*2;
    writematrix([nonExistingID nonExistingParams Class], file, 'Delimiter','tab');
end