function Iout = readAndPreprocessImageForAlexNet(filename,preProc)

% preProc = 0 : just resize
% preProc = 1 : apply difference of Gaussians
% preProc = 2 : apply LBP
% preProc = 3 : gradient

[filepath,name,ext] = fileparts(filename);
if preProc == 1 % DoG
    if strcmp(ext,'.png')
        img = imread(filename);
        
        OctaveImageDiff=differenceOfGaussians(img);%size(OctaveImageDiff)
        dogImg1=OctaveImageDiff{1,1};size(dogImg1);dogImg1=imresize(dogImg1,size(img));%size(dogImg1)
        dogImg2=OctaveImageDiff{1,2};size(dogImg2);dogImg2=imresize(dogImg2,size(img));%size(dogImg2)
        dogImg3=OctaveImageDiff{1,3};size(dogImg3);dogImg3=imresize(dogImg3,size(img));%size(dogImg3)
        
        dogImg1=(dogImg1-min(dogImg1(:)))/(max(dogImg1(:))-min(dogImg1(:)));
        dogImg2=(dogImg2-min(dogImg2(:)))/(max(dogImg2(:))-min(dogImg2(:)));
        dogImg3=(dogImg3-min(dogImg3(:)))/(max(dogImg3(:))-min(dogImg3(:)));
        
        img = cat(3,255*dogImg1,255*dogImg2,255*dogImg3);
        
        % Resize the image as required for the AlexNet CNN.
        Iout = imresize(img, [227 227]);
    else
        load(filename);
    end
elseif preProc == 2 % LBP
    if strcmp(ext,'.png')
        imgOrig = imread(filename);
        
        radius1 = 1;
        Input_Im = imresize(imgOrig, [227+2*radius1 227+2*radius1]);
        LBP_Im1 = LBP(Input_Im,  1);
        
        radius1 = 15;
        Input_Im = imresize(imgOrig, [227+2*radius1 227+2*radius1]);
        LBP_Im2 = LBP(Input_Im, 15);
        
        radius1 = 30;
        Input_Im = imresize(imgOrig, [227+2*radius1 227+2*radius1]);
        LBP_Im3 = LBP(Input_Im, 30);
        
        img = cat(3,LBP_Im1,LBP_Im2,LBP_Im3);
        
        % Resize the image as required for the AlexNet CNN.
        Iout = imresize(img, [227 227]);
    else
        load(filename);
    end
elseif preProc == 3 % gradient
    if strcmp(ext,'.png')
        img = imread(filename);
        [Gmag,Gdir] = imgradient(img);
        img = cat(3,img,Gmag,Gdir);
        Iout = imresize(img, [227 227]);
    else
        load(filename);
    end
else
    % Some images may be grayscale.
    % Replicate the image 3 times to create an RGB image.
    img = imread(filename);
    if ismatrix(img)
        img = cat(3,img,img,img);
    end
    % Resize the image as required for the AlexNet CNN.
    Iout = imresize(img, [227 227]);
end