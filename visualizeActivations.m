close all; clear; clc
sourceFolder = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData';
imgToLoad    = strcat(sourceFolder,'\isAugmented0_isBalanced0_isGaussian0\1\50994733_069212ec65a94339_l_ml_withMask_padded.png');
showConfMat=1;

for rep = 1% : 40
    for isGaussian =1% [0 1]
        for isAugmented =1% [0 1 2] % no augmentation ; only adds flipped images ; proposed augmentation
            for isBalanced =0% [1 0]
                strToLoad = strcat(sourceFolder,'\resultsAlexNet_isAugmented',num2str(isAugmented),...
                    '_isBalanced',num2str(isBalanced),...
                    '_isGaussian',num2str(isGaussian),...
                    '_rep',num2str(rep),'.mat');
                load(strToLoad) % netTransfer
                netTransfer.Layers
                
                if showConfMat
                    nrSamples = length(testLabels);
                    testLabelsMatrix      = zeros(6,nrSamples);
                    predictedLabelsMatrix = zeros(6,nrSamples);
                    for i = 1 : nrSamples
                        testLabelsMatrix( testLabels(i) , i ) = 1 ;
                        predictedLabelsMatrix( predictedLabels(i) , i ) = 1 ;
                    end
                    %[C,order] = confusionmat(testLabels,predictedLabels)
                    figure; plotconfusion(testLabelsMatrix,predictedLabelsMatrix,...
                        ['isAugmented ' num2str(isAugmented) '; isBalanced ' num2str(isBalanced) '; isGaussian ' num2str(isGaussian) '.'])
                end
                
                % Load input image
                %im = imread(imgToLoad);
                imdTest = readAndPreprocessImageForAlexNet(imgToLoad,isGaussian);
                im = round( 255 .* (imdTest - min(imdTest(:))) ./ ( max(imdTest(:)) - min(imdTest(:))));
                im = uint8(im);
                figure; imshow(im); title('input image')
                imgSize = size(im);
                imgSize = imgSize(1:2);
                predictedLabel = classify(netTransfer,imdTest)
                
                % Show Activations of First Convolutional Layer
                act1 = activations(netTransfer,im,'conv1','OutputAs','channels');
                sz = size(act1);
                act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
                figure; montage(mat2gray(act1),'Size',[8 12]);title('Activations of First Convolutional Layer') % Display a montage of the 96 images on an 8-by-12 grid, one for each channel in the layer.
                
                %                 % Investigate the Activations in Specific Channels
                %                 act1ch32 = act1(:,:,:,32);
                %                 act1ch32 = mat2gray(act1ch32);
                %                 act1ch32 = imresize(act1ch32,imgSize);
                %                 figure; imshowpair(im,act1ch32,'montage'); title('activations in channel 32')
                
                % Find the Strongest Activation Channel
                [maxValue,maxValueIndex] = max(max(max(act1)));
                act1chMax = act1(:,:,:,maxValueIndex);
                act1chMax = mat2gray(act1chMax);
                act1chMax = imresize(act1chMax,imgSize);
                figure; imshowpair(im,act1chMax,'montage');title(['channel with the largest activation : ' num2str(maxValueIndex)])
                
                % Investigate a Deeper Layer
                act5 = activations(netTransfer,im,'conv5','OutputAs','channels');
                sz = size(act5);
                act5 = reshape(act5,[sz(1) sz(2) 1 sz(3)]);
                figure;montage(imresize(mat2gray(act5),[48 48]));title('conv5 layer')
                
                [maxValue5,maxValueIndex5] = max(max(max(act5)));
                act5chMax = act5(:,:,:,maxValueIndex5);
                figure; imshow(imresize(mat2gray(act5chMax),imgSize));title(['strongest activation in the conv5 layer : ' num2str(maxValueIndex5)])
                
                %                 figure; montage(imresize(mat2gray(act5(:,:,:,[3 5])),imgSize)); title('channels 3 and 5')
                
                act5relu = activations(netTransfer,im,'relu5','OutputAs','channels');
                sz = size(act5relu);
                act5relu = reshape(act5relu,[sz(1) sz(2) 1 sz(3)]);
                figure; montage(imresize(mat2gray(act5relu(:,:,:,[3 5])),imgSize));title('only positive activations')
            end
        end
    end
end