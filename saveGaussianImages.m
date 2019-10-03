close all; clear; clc
sourceFolder = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\evaluationData';

for isAugmented = [0 1 2] % no augmentation ; only adds flipped images ; proposed augmentation
    for isBalanced = [1 0]
        for class = 1 : 6
            disp(strcat(' -> isAugmented = ',num2str(isAugmented),' ; isBalanced = ',num2str(isBalanced),' ; class = ',num2str(class) ));
            folderOfOrigin = strcat(sourceFolder,...
                '\isAugmented',num2str(isAugmented),'_isBalanced',num2str(isBalanced),'_isGaussian0\',num2str(class));
            
            %             preProc = 1;
            %             destinationFolder = strcat(sourceFolder,...
            %                 '\isAugmented',num2str(isAugmented),'_isBalanced',num2str(isBalanced),'_isGaussian',num2str(preProc),'\',num2str(class));
            %             if exist(destinationFolder)~=7
            %                 mkdir(destinationFolder);
            %             end
            %             files = dir(folderOfOrigin);
            %             for f = 3 : length(files)
            %                 filenameDestiny = strcat(destinationFolder,'\',files(f).name);
            %                 [filepath,name,ext] = fileparts(filenameDestiny);
            %                 filenameDestiny = strcat(filepath,'\',name,'.mat');
            %                 if exist(filenameDestiny)~=2
            %                     filenameOrigin = strcat(folderOfOrigin,'\',files(f).name);
            %                     Iout = readAndPreprocessImageForAlexNet(filenameOrigin,preProc);
            %                     save(filenameDestiny,'Iout');
            %                 end
            %             end
            %             preProc = 2;
            %             destinationFolder = strcat(sourceFolder,...
            %                 '\isAugmented',num2str(isAugmented),'_isBalanced',num2str(isBalanced),'_isGaussian',num2str(preProc),'\',num2str(class));
            %             if exist(destinationFolder)~=7
            %                 mkdir(destinationFolder);
            %             end
            %             files = dir(folderOfOrigin);
            %             for f = 3 : length(files)
            %                 filenameDestiny = strcat(destinationFolder,'\',files(f).name);
            %                 [filepath,name,ext] = fileparts(filenameDestiny);
            %                 filenameDestiny = strcat(filepath,'\',name,'.mat');
            %                 if exist(filenameDestiny)~=2
            %                     filenameOrigin = strcat(folderOfOrigin,'\',files(f).name);
            %                     Iout = readAndPreprocessImageForAlexNet(filenameOrigin,preProc);
            %                     save(filenameDestiny,'Iout');
            %                 end
            %             end
            
            preProc = 3;
            destinationFolder = strcat(sourceFolder,...
                '\isAugmented',num2str(isAugmented),'_isBalanced',num2str(isBalanced),'_isGaussian',num2str(preProc),'\',num2str(class));
            if exist(destinationFolder)~=7
                mkdir(destinationFolder);
            end
            files = dir(folderOfOrigin);
            for f = 3 : length(files)
                filenameDestiny = strcat(destinationFolder,'\',files(f).name);
                [filepath,name,ext] = fileparts(filenameDestiny);
                filenameDestiny = strcat(filepath,'\',name,'.mat');
                if exist(filenameDestiny)~=2
                    filenameOrigin = strcat(folderOfOrigin,'\',files(f).name);
                    Iout = readAndPreprocessImageForAlexNet(filenameOrigin,preProc);
                    save(filenameDestiny,'Iout');
                end
            end
        end
    end
end
%classifyWithAlexNet