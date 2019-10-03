close all; clear; clc
sourceFolder = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData';

disp('Get GPU device information')
deviceInfo = gpuDevice;

disp('Check the GPU compute capability')
computeCapability = str2double(deviceInfo.ComputeCapability);
assert(computeCapability >= 3.0, 'This example requires a GPU device with compute capability 3.0 or higher.')

%%
disp('Load pre-trained AlexNet')
%(Other popular networks trained on ImageNet include VGG-16 and VGG-19 [3], which can be loaded using vgg16 and vgg19 from the Neural Network Toolbox™.)
net = alexnet();

disp('Transfer Layers to New Network')
layersTransfer = net.Layers(1:end-3);
miniBatchSize = 10;numClasses = 6;
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

for rep = 1 : 10 % 40
    disp(strcat('Rep = ',num2str(rep)))
    for isGaussian = [0 1 2 3] % just resize ; apply difference of Gaussians ; apply LBP; gradient
        for isAugmented = [0 1 2] % no augmentation ; only adds flipped images ; proposed augmentation
            for isBalanced =  [1 0]
                disp(strcat('   -> isAugmented = ',num2str(isAugmented),' ; isBalanced = ',num2str(isBalanced),' ; isGaussian = ',num2str(isGaussian) ))
                strToSave = strcat(sourceFolder,'\resultsAlexNet_isAugmented',num2str(isAugmented),...
                    '_isBalanced',num2str(isBalanced),...
                    '_isGaussian',num2str(isGaussian),...
                    '_rep',num2str(rep),'.mat');
                if exist(strToSave)~=2
                    % try
                    % disp(' Data Location')
                    rootFolder = strcat(sourceFolder,'\isAugmented',num2str(isAugmented),'_isBalanced',num2str(isBalanced),'_isGaussian',num2str(isGaussian));
                    categories = {'1', '2', '3', '4', '5', '6'};
                    
                    % % Verify if all the test folders have data
                    % categoriesTest={};
                    % testFolders = fullfile(rootFolder, categories);
                    % for c=1:length(testFolders)
                    % if length(dir(testFolders{c}))>2
                    % categoriesTest=[categoriesTest,categories{c}];
                    % end
                    % end
                    % categoriesTest
                    
                    % disp(' Create an ImageDatastore to help manage the data.')
                    if isGaussian
                        imdsTrain = imageDatastore(fullfile(rootFolder                  , categories),'FileExtensions', '.mat','LabelSource','foldernames');
                    else
                        imdsTrain = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
                    end
                    imdsTest  = imageDatastore(fullfile(strcat(sourceFolder,'\test'), categories), 'LabelSource', 'foldernames');
                    
                    %%
                    % disp(' Set the ImageDatastore ReadFcn')
                    imdsTrain.ReadFcn = @(filename)readAndPreprocessImageForAlexNet(filename,isGaussian);
                    imdsTest.ReadFcn = @(filename)readAndPreprocessImageForAlexNet(filename,isGaussian);
                    
                    % disp(' Shuffle')
                    imdsTrain = shuffle(imdsTrain);
                    imdsTest = shuffle(imdsTest);
                    
                    % disp(' set train options')
                    [trainingImages,validationImages] = splitEachLabel(imdsTrain,0.7,'randomized');
                    numIterationsPerEpoch = floor(numel(trainingImages.Labels)/miniBatchSize);
                    options = trainingOptions('sgdm',...
                        'MiniBatchSize',miniBatchSize,...
                        'MaxEpochs',4,...
                        'InitialLearnRate',1e-4,...
                        'Verbose',false,...
                        'ValidationData',validationImages,...
                        'ValidationFrequency',numIterationsPerEpoch);
                    
                    % disp(' train')
                    tic
                    netTransfer = trainNetwork(trainingImages,layers,options);
                    elapsedTime = toc;
                    disp(['      elapsedTime: ' num2str(elapsedTime)])
                    
                    % disp(' Test')
                    predictedLabels = classify(netTransfer,imdsTest);
                    
                    % disp(' Get the known labels')
                    testLabels = imdsTest.Labels;
                    
                    % disp(' Tabulate the results using a confusion matrix.')
                    % C(i,j) is a count of observations known to be in group i but predicted to be in group j
                    confMat = confusionmat(testLabels, predictedLabels);
                    
                    % disp(' Convert confusion matrix into percentage form')
                    confMat = bsxfun(@rdivide,confMat,sum(confMat,2));
                    
                    % Display the mean accuracy
                    disp(['      Acc: ' num2str(mean(diag(confMat)))])
                    %mean(diag(confMat))
                    
                    MAE=computeMAE(testLabels,predictedLabels);
                    disp(['      MAE: ' num2str(MAE)])
                    
                    save(strToSave)
                    % end
%                 else
%                     disp('   ---> DONE')
                end
            end
        end
    end
end
% tbl = countEachLabel(trainingImages)
% tbl = countEachLabel(validationImages)
% tbl = countEachLabel(imdsTest)

load handel
sound(y,Fs)