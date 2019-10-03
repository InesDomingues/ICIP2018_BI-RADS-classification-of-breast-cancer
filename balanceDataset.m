close all; clear; clc
sourceFolder   = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData\isAugmented2_isBalanced0_full\';
balancedFolder = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData\isAugmented2_isBalanced1\';

% verify what is the minimum number of examples per class:
nrExamplesPerClass=+inf;
for class=1:6
    source = strcat(sourceFolder,'\',num2str(class));
    files = dir(source);
    nrExamplesAugmented=length(dir(strcat(sourceFolder,'\',num2str(class))))-2;
    if nrExamplesAugmented<nrExamplesPerClass
        nrExamplesPerClass=nrExamplesAugmented;
    end
end
disp(['nrExamplesPerClass ' num2str(nrExamplesPerClass)])

nrExamplesPerClass = 260;

% copy data
for class=1:6
    disp(['class ' num2str(class)])
    source = strcat(sourceFolder,'\',num2str(class));
    files = dir(source);
    nrExamplesAugmented=length(dir(strcat(sourceFolder,'\',num2str(class))))-2;
    r = rand(nrExamplesAugmented,1); [r,idx]=sort(r);idx=idx(1:nrExamplesPerClass)+2;
    
    destinationFolder = strcat(balancedFolder,'\',num2str(class));
    if exist(destinationFolder)~=7
        mkdir(destinationFolder)
    end
    nrFilesAlreadyThere = length(dir(destinationFolder))-2;
    if nrFilesAlreadyThere<nrExamplesPerClass
        for i=1:nrExamplesPerClass
            disp(['   example ' num2str(i) ' of ' num2str(nrExamplesPerClass) ' ( per = ' num2str(round(100*(i/nrExamplesPerClass))) ' )'])
            copyfile(strcat(sourceFolder,'\',num2str(class),'\',files(idx(i)).name),destinationFolder);
            nrFilesAlreadyThere = length(dir(destinationFolder))-2;
            if nrFilesAlreadyThere>=nrExamplesPerClass
                break
            end
            
        end
    end
end