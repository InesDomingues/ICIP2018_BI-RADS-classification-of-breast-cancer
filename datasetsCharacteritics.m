close all; clear; clc
sourceFolderHere = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData';
augmentationSTR = {'none';'mirrored';'proposed'};
balanceSTR = {'no';'yes'};
for isGaussian =0 % [0 1]
    for isAugmented = [0 1 2] % no augmentation ; only adds flipped images ; proposed augmentation
        for isBalanced = [1 0]
            strToLoad = strcat(sourceFolderHere,'\isAugmented',num2str(isAugmented),...
                '_isBalanced',num2str(isBalanced),...
                '_isGaussian',num2str(isGaussian));
            strToDisp=[];
            if exist(strToLoad)==7
                nrExamples=[];
                strToDisp=strcat(augmentationSTR{isAugmented+1},' & ',balanceSTR{isBalanced+1});
                for class=1:6
                    nrExamples(class)=length(dir(strcat(strToLoad,'\',num2str(class))))-2;
                    strToDisp = strcat(strToDisp,' & ',num2str(nrExamples(class)));
                end
            end
            strToDisp = strcat(strToDisp,' & ',num2str(sum(nrExamples)),'\\');
            disp(strToDisp)
            hold on; plot(1:6,nrExamples./sum(nrExamples))
        end
        disp('\hline')
    end
end
disp('\hline')
strToLoad = strcat(sourceFolderHere,'\test');
strToDisp=[];
if exist(strToLoad)==7
    nrExamples=[];
    strToDisp=strcat('\multicolumn{2}{|c|}{test set} ');
    for class=1:6
        nrExamples(class)=length(dir(strcat(strToLoad,'\',num2str(class))))-2;
        strToDisp = strcat(strToDisp,' & ',num2str(nrExamples(class)));
    end
end
strToDisp = strcat(strToDisp,' & ',num2str(sum(nrExamples)),'\\');
disp(strToDisp)
disp('\hline')