close all; clear; clc
sourceFolder   = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData\isAugmented2_isBalanced0_full\';
balancedFolder = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData\isAugmented2_isBalanced0\';

% verify what is the minimum number of examples per class:
nrExamplesPerClass=+inf;
for class=1:6
    source = strcat(sourceFolder,'\',num2str(class));
    files = dir(source);
    nrExamplesPerClass(class)=length(dir(strcat(sourceFolder,'\',num2str(class))))-2;
end
nrExamplesPerClass=[1490 5384 749 880 1239 260];%round(nrExamplesPerClass/2)

% copy data
for class=1:6
    disp(['class ' num2str(class)])
    source = strcat(sourceFolder,'\',num2str(class));
    files = dir(source);
    nrExamplesAugmented=length(dir(strcat(sourceFolder,'\',num2str(class))))-2;
    r = rand(nrExamplesAugmented,1); [r,idx]=sort(r);idx=idx(1:nrExamplesPerClass(class))+2;
    
    destinationFolder = strcat(balancedFolder,'\',num2str(class));
    if exist(destinationFolder)~=7
        mkdir(destinationFolder)
    end
    nrFilesAlreadyThere = length(dir(destinationFolder))-2;
    if nrFilesAlreadyThere<nrExamplesPerClass(class)
        for i=1:nrExamplesPerClass(class)
            %disp(['   example ' num2str(i) ' of ' num2str(nrExamplesPerClass(class)) ' ( per = ' num2str(round(100*(i/nrExamplesPerClass(class)))) ' )'])
            copyfile(strcat(sourceFolder,'\',num2str(class),'\',files(idx(i)).name),destinationFolder);
            nrFilesAlreadyThere = length(dir(destinationFolder))-2;
            if nrFilesAlreadyThere>=nrExamplesPerClass(class)
                break
            end
            
        end
    end
end