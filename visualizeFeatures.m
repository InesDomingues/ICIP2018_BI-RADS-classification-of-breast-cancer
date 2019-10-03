close all; clear; clc
sourceFolder = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData';

for rep = 1% : 40
    for isGaussian =1% [0 1]
        for isAugmented =1% [0 1 2] % no augmentation ; only adds flipped images ; proposed augmentation
            for isBalanced =0% [1 0]
                strToLoad = strcat(sourceFolder,'\resultsAlexNet_isAugmented',num2str(isAugmented),...
                    '_isBalanced',num2str(isBalanced),...
                    '_isGaussian',num2str(isGaussian),...
                    '_rep',num2str(rep),'.mat');
                load(strToLoad) % netTransfer
                
                for layer = [2 6 10 12 14]
                    name = netTransfer.Layers(layer).Name
                    channels = 1:30;
                    I = deepDreamImage(netTransfer,layer,channels, 'PyramidLevels',1);
                    figure; montage(I); title(['Layer ',name,' Features'])
                end
                
                layers = [17 20];
                channels = 1:6;
                for layer = layers
                    I = deepDreamImage(netTransfer,layer,channels, ...
                        'Verbose',false, ...
                        'NumIterations',50);
                    figure; montage(I)
                    name = netTransfer.Layers(layer).Name;
                    title(['Layer ',name,' Features'])
                end
                
                layer = 23;
                channels = 1:6;
                netTransfer.Layers(end).ClassNames(channels)
                I = deepDreamImage(netTransfer,layer,channels, ...
                    'Verbose',false, ...
                    'NumIterations',50);
                figure;montage(I)
                name = netTransfer.Layers(layer).Name;
                title(['Layer ',name,' Features'])
            end
        end
    end
end