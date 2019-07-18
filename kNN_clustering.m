fileID=fopen('DualExisting_pca.txt','r'); % change this according to what you want to classify
lines_pca=textscan(fileID,'%s%f%f%d');
fclose(fileID);
Params_existing=[lines_pca{2} lines_pca{3}];
Class_existing=[lines_pca{4}];

Loss_percentage=zeros(10,15);

for trial = 1:10,
    
    file=sprintf('DualNonExisting_pca_%d.txt',trial); % change this according to what you want to classify
    fileID=fopen(file,'r'); % change this according to what you want to classify
    lines_pca=textscan(fileID,'%s%f%f%d');
    fclose(fileID);
    
    Params_nonexisting=[lines_pca{2} lines_pca{3}];
    Class_nonexisting=[lines_pca{4}];
    
    Params=[Params_existing;Params_nonexisting];
    Class=[Class_existing;Class_nonexisting];

    for k = 1:15,
        
        trial, k
       
        Mdl = fitcknn(Params,Class,'NumNeighbors',k,'Leaveout','on');
        Loss_percentage(trial,k)=Mdl.kfoldLoss();
        
    end
end

Loss_percentage

mean(Loss_percentage)