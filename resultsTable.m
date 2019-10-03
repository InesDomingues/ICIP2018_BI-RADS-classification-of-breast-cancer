close all; clear; clc
% sourceFolderHere = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData';
% 
% showConfMat = 0;
% 
% inputSTR = {'image';'DoG';'LBP';'gradient'};
% augmentationSTR = {'none';'mirrored';'proposed'};
% balanceSTR = {'no';'yes'};
% table=[];
% for isGaussian = [0 1 2 3] % just resize ; apply difference of Gaussians ; apply LBP; gradient
%     for isAugmented = [0 1 2] % no augmentation ; only adds flipped images ; proposed augmentation
%         for isBalanced = [1 0]
%             metrics=[];
%             for rep = 1 : 10
%                 strToLoad = strcat(sourceFolderHere,'\resultsAlexNet_isAugmented',num2str(isAugmented),...
%                     '_isBalanced',num2str(isBalanced),...
%                     '_isGaussian',num2str(isGaussian),...
%                     '_rep',num2str(rep),'.mat');
%                 if exist(strToLoad)==2
%                     load(strToLoad);
%                     if showConfMat
%                         nrSamples = length(testLabels);
%                         testLabelsMatrix      = zeros(6,nrSamples);
%                         predictedLabelsMatrix = zeros(6,nrSamples);
%                         for i = 1 : nrSamples
%                             testLabelsMatrix( testLabels(i) , i ) = 1 ;
%                             predictedLabelsMatrix( predictedLabels(i) , i ) = 1 ;
%                         end
%                         %[C,order] = confusionmat(testLabels,predictedLabels)
%                         figure; plotconfusion(testLabelsMatrix,predictedLabelsMatrix,...
%                             ['isAugmented ' num2str(isAugmented) '; isBalanced ' num2str(isBalanced) '; isGaussian ' num2str(isGaussian) '.'])
%                     end
%                     Acc=computeAccuracy(testLabels,predictedLabels);
%                     MAE=computeMAE(testLabels,predictedLabels);
%                     New=computeNewMetric(testLabels,predictedLabels);
%                     metrics(rep,:) = 100 * [Acc New MAE];
% 
%                     Acc_stack(isGaussian+1,isAugmented+1,isBalanced+1,rep) = Acc;
%                     MAE_stack(isGaussian+1,isAugmented+1,isBalanced+1,rep) = MAE;
%                     New_stack(isGaussian+1,isAugmented+1,isBalanced+1,rep) = New;
%                 end
%             end
%             means = round(mean(metrics)*10)/10;
%             stds  = round(std(metrics)*10)/10;
%             disp(strcat(inputSTR{isGaussian+1},' & ',augmentationSTR{isAugmented+1},' & ',balanceSTR{isBalanced+1},' & ',...
%                 num2str(means(1)),'(',num2str(stds(1)),')',' & ',...
%                 num2str(means(2)),'(',num2str(stds(2)),')',' & ',...
%                 num2str(means(3)),'(',num2str(stds(3)),') \\'));
%             table = [table; isGaussian isAugmented isBalanced means];
%         end
%         disp('\hline')
%     end
%     disp('\hline')
% end
% [a,b]=max(table(:,4));disp(strcat('Best Acc : ',inputSTR{table(b,1)+1},' ; ',augmentationSTR{table(b,2)+1},' ; ',balanceSTR{table(b,3)+1},' -> ', num2str(table(b,4))))
% [a,b]=max(table(:,5));disp(strcat('Best MaxAcc : ',inputSTR{table(b,1)+1},' ; ',augmentationSTR{table(b,2)+1},' ; ',balanceSTR{table(b,3)+1},' -> ', num2str(table(b,5))))
% [a,b]=min(table(:,6));disp(strcat('Best MAE : ',inputSTR{table(b,1)+1},' ; ',augmentationSTR{table(b,2)+1},' ; ',balanceSTR{table(b,3)+1},' -> ', num2str(table(b,6))))
% save
% load
% 
% % The effect of the input
% for isGaussian = [0 1 2 3] % just resize ; apply difference of Gaussians ; apply LBP; gradient
%     for isAugmented = [0 1 2] % no augmentation ; only adds flipped images ; proposed augmentation
%         for isBalanced = [1 0]
%             isGaussian = 0
%             isGaussian = 1
%             isGaussian = 2
%             isGaussian = 3
%         end
%     end
% end
% 
% values = unique(table(:,1));
% for v1 = 1 : length(values)
%     a = find(table(:,1)==values(v1));
%     for v2 = 1 : length(values)
%         b = find(table(:,1)==values(v2));
%         ttest2(table(a,5),table(b,5))
%         ttest2(table(a,6),table(b,6))
%     end
% end
% % 
% % % The effect of the data augmentation
% % [table([1 2 7 8],5)-table([3 4 9 10],5) table([3 4 9 10],5)-table([5 6 11 12],5) table([5 6 11 12],5)-table([1 2 7 8],5)]
% % [table([1 2 7 8],6)-table([3 4 9 10],6) table([3 4 9 10],6)-table([5 6 11 12],6) table([5 6 11 12],6)-table([1 2 7 8],6)]
% % 
% % % The effect of the imbalance
% % [table(1:2:end,5)-table(2:2:end,5)]
% % [table(1:2:end,6)-table(2:2:end,6)]
% % 
% % %h = ttest2(x,y) returns a test decision for the null hypothesis that the
% % % data in vectors x and y comes from independent random samples from normal
% % % distributions with equal means and equal but unknown variances, using the
% % % two-sample t-test. The alternative hypothesis is that the data in x and y
% % % comes from populations with unequal means. The result h is 1 if the test
% % % rejects the null hypothesis at the 5% significance level, and 0 otherwise.
% % close all; clear; clc
% % sourceFolderHere = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData';
% % inputSTR = {'image';'DoG';'LBP';'gradient'};
% % augmentationSTR = {'none';'mirrored';'proposed'};
% % balanceSTR = {'no';'yes'};
% % 
% % % The effect of the input
% % for isAugmented = [0 1 2] % no augmentation ; only adds flipped images ; proposed augmentation
% %     for isBalanced = [1 0]
% %         metrics=[];
% %         for rep = 1 : 10
% %             
% %             isGaussian = 0;
% %             strToLoad = strcat(sourceFolderHere,'\resultsAlexNet_isAugmented',num2str(isAugmented),...
% %                 '_isBalanced',num2str(isBalanced),...
% %                 '_isGaussian',num2str(isGaussian),...
% %                 '_rep',num2str(rep),'.mat');
% %             load(strToLoad);
% %             Acc0(rep)=computeAccuracy(testLabels,predictedLabels);
% %             MAE0(rep)=computeMAE(testLabels,predictedLabels);
% %             New0(rep)=computeNewMetric(testLabels,predictedLabels);
% %             
% %             isGaussian = 1;
% %             strToLoad = strcat(sourceFolderHere,'\resultsAlexNet_isAugmented',num2str(isAugmented),...
% %                 '_isBalanced',num2str(isBalanced),...
% %                 '_isGaussian',num2str(isGaussian),...
% %                 '_rep',num2str(rep),'.mat');
% %             load(strToLoad);
% %             Acc1(rep)=computeAccuracy(testLabels,predictedLabels);
% %             MAE1(rep)=computeMAE(testLabels,predictedLabels);
% %             New1(rep)=computeNewMetric(testLabels,predictedLabels);
% %         end
% %         hAcc = ttest2(Acc0,Acc1)
% %         hMAE = ttest2(MAE0,MAE1)
% %         hNew = ttest2(New0,New1)
% %         disp(augmentationSTR{isAugmented+1},' & ',balanceSTR{isBalanced+1},' & ',...
% %             num2str(hAcc),' & ',...
% %             num2str(hMAE),' & ',...
% %             num2str(hNew));
% %     end
% % end